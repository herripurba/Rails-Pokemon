class BattlesController < ApplicationController

    skip_before_action :verify_authenticity_token
    
    $element_chart = {"Fire" => {"Fire" => 1, "Water" => 0.5, "Grass" => 2, "Normal" => 1},
                    "Water" => {"Fire" => 2, "Water" => 1, "Grass" => 0.5, "Normal" => 1},
                    "Grass" => {"Fire" => 0.5, "Water" => 2, "Grass" => 1, "Normal" => 1},
                    "Normal" => {"Fire" => 1, "Water" => 1, "Grass" => 1, "Normal" => 1}
    }


    $max_exp = {1=>100, 2=>150, 3=>200, 4=>250, 5=>300, 6=>350, 7=>400, 8=>450, 9=>500, 10=>550, 11=>600, 12=>650, 13=>700, 14=>750, 15=>800, 16=>850, 17=>900, 18=>950,19=>1000, 20=>1050, 21=>1100, 22=>1150, 23=>1200, 24=>1250 ,25=>1300,
        26=>1350, 27=>1400, 28=>1450, 29=>1500, 30=>1550, 31=>1600, 32=>1650, 33=>1700, 34=>1750, 35=>1800, 36=>1850, 37=>1900, 38=>1950, 39=>2000, 40=>2050, 41=>2100, 42=>2150, 43=>2200, 44=>2250, 45=>2300, 46=>2350, 47=>2400, 48=>2450, 49=>2500, 50=>2550, 
        51=>2600, 52=>2650, 53=>2700, 54=>2750, 55=>2800, 56=>2850, 57=>2900, 58=>2950, 59=>3000, 60=>3050, 61=>3100, 62=>3150, 63=>3200, 64=>3250, 65=>3300, 66=>3350, 67=>3400, 68=>3450, 69=>3500, 70=>3550, 71=>3600, 72=>3650, 73=>3700, 74=>3750, 75=>3800, 
        76=>3850, 77=>3900, 78=>3950, 79=>4000, 80=>4050, 81=>4100, 82=>4150, 83=>4200, 84=>4250, 85=>4300, 86=>4350, 87=>4400, 88=>4450, 89=>4500, 90=>4550, 91=>4600, 92=>4650, 93=>4700, 94=>4750, 95=>4800, 96=>4850, 97=>4900, 98=>4950, 99=>5000, 100=>5050
    }

    LEVEL_MAX = 100

    BASE_EXP = 50
    EXP_BONUS = 2.5
    EXP_PUNISH = 3.75

    # $exp = 1000

    def index
        @battles = Battle.all.order(id: :asc)
    end

    def new
        @battle  = Battle.new
        @pokemons = Pokemon.where("is_delete = ?", "false").order(id: :asc)
        $skills = Array.new
    end

    def show
        @battle = Battle.find(params[:id])
        # @pokemons = Pokemon.all
        @pokemon_i = Pokemon.find(@battle.pokemon_i_id)
        @pokemon_ii = Pokemon.find(@battle.pokemon_ii_id)
        @pokemon_i_skills = @pokemon_i.pokemon_skills.order(id: :asc)
        @pokemon_ii_skills = @pokemon_ii.pokemon_skills.order(id: :asc)

        # puts "ini tambah skill", $skills
    end
    
    
    def create
        @battle = Battle.new(battle_params)
        @battle.battle_date = Time.now
        
        if @battle.pokemon_i_id != 0 && @battle.pokemon_ii_id != 0
            puts @battle.pokemon_i_id
            if @battle.pokemon_i.pokemon_speed >= @battle.pokemon_ii.pokemon_speed 
                @battle.current_attacker_id = @battle.pokemon_i_id
            elsif @battle.pokemon_i.pokemon_speed < @battle.pokemon_ii.pokemon_speed
                @battle.current_attacker_id = @battle.pokemon_ii_id
            end
        end

        
        if @battle.save
            @battle.pokemon_i.status ="In Battle"
            @battle.pokemon_ii.status ="In Battle"
            @battle.pokemon_i.save
            @battle.pokemon_ii.save
            
            @battle.header_message = @battle.current_attacker.name.titleize + " first attacker"
            @battle.save

            flash[:success] = "Battle created successfully"
            redirect_to battle_path(@battle)
        else
            @pokemons = Pokemon.where("is_delete = ?", "false")
            render :new, status: :unprocessable_entity
        end
    end

    def attack
        @battle_detail = BattleDetail.new(battle_detail_params)
        
        # puts "battle detail",  @battle_detail

        @battle = Battle.find(@battle_detail.battle_id)
        
        @@pokemon_attack = Pokemon.find(params[:pokemon_attack_id])
        @@pokemon_got_damage = Pokemon.find(params[:pokemon_got_damage_id])
        @@pokemon_skill = PokemonSkill.find(@battle_detail.skill_id)
        
        # Decrement pp and calculate damage
        if @battle.status != "End"
            puts "kurangi pp"
            @@pokemon_skill.last_pp -= 1
            @@pokemon_skill.save
        end
        
        damage = damage_calculation()
        
        if @@pokemon_got_damage.pokemon_hp > damage
            @@pokemon_got_damage.pokemon_hp -= damage
            @@pokemon_got_damage.save
        else
            @@pokemon_got_damage.pokemon_hp -= @@pokemon_got_damage.pokemon_hp
            @@pokemon_got_damage.save
        end
        
        @battle_detail.skill_id = @@pokemon_skill.skill_id
        @battle_detail.damage = damage
        @battle_detail.enemy_hp = @@pokemon_got_damage.pokemon_hp
        @battle_detail.save
        # End

        # Update battle winner and status on pokemon
        if hp_check or pp_check
            @battle.winner_id = @@pokemon_attack.id
            @battle.status = "End"
            @battle.game_over = true
            @battle.save
            
            attacker_pp = @@pokemon_attack.pokemon_skills.all? {|pokemon_skill| pokemon_skill.last_pp == 0}

            if hp_check
                @@pokemon_got_damage.status = "Death"
                @@pokemon_got_damage.save
            elsif pp_check
                @@pokemon_got_damage.status = "No PP"
                @@pokemon_got_damage.save
            end

            @@pokemon_attack.status = "Free"
            @@pokemon_attack.save
            if attacker_pp
                @@pokemon_attack.status = "No PP"
                @@pokemon_attack.save
            end

            @exp_calculation = exp_calculation()
            exp_winner = @@pokemon_attack.pokemon_exp + @exp_calculation
            if exp_winner >= @@pokemon_attack.pokemon_max_exp
                # puts "masuk sini kk"
                # Level_up state
                @battle.level_up = true
                @battle.pokemon_level_up_id = @@pokemon_attack.id
                @battle.save

                if @battle.level_up
                    # puts "level up"
                    
                    @battle.winner_hp = @@pokemon_attack.pokemon_hp
                    @battle.winner_max_hp = @@pokemon_attack.pokemon_max_hp
                    @battle.winner_level_old = @@pokemon_attack.level
                    @battle.loser_hp = @@pokemon_got_damage.pokemon_hp
                    @battle.loser_max_hp = @@pokemon_got_damage.pokemon_max_hp
                    @battle.loser_level = @@pokemon_got_damage.level
                    @battle.winner_exp = @@pokemon_attack.pokemon_exp
                    @battle.winner_max_exp = @@pokemon_attack.pokemon_max_exp
                    @battle.winner_attack_old = @@pokemon_attack.pokemon_attack
                    @battle.winner_defence_old = @@pokemon_attack.pokemon_defence
                    @battle.winner_special_old = @@pokemon_attack.pokemon_special
                    @battle.winner_speed_old = @@pokemon_attack.pokemon_speed
                    @battle.save

                    arr = level_up()

                    @battle.winner_level_plus = arr[5]
                    @battle.winner_hp_plus = arr[4]
                    @battle.winner_exp_plus = @exp_calculation
                    @battle.winner_attack_plus = arr[0]
                    @battle.winner_defence_plus = arr[1]
                    @battle.winner_special_plus = arr[2]
                    @battle.winner_speed_plus = arr[3]
                    @battle.header_message = @@pokemon_attack.name+" Level Up"
                    @battle.save


                    # message = @@pokemon_attack.name+" Level Up"
                    # flash[:notice] = message.titleize 
                end

                if $skills.length != 0
                    # z = 3
                    
                    while @battle.winner.pokemon_skills.count < 4 && $skills.length != 0
                        skill = $skills.shift

                        # puts "ini skill id nya", skill
                        @new_skill = Skill.find(skill)
                        @pokemon_skill = PokemonSkill.new
                        @pokemon_skill.pokemon_id = @battle.winner_id
                        @pokemon_skill.skill_id = skill
                        @pokemon_skill.last_pp = @new_skill.pp
                        @pokemon_skill.save

                        @battle.skill_id = skill
                        @battle.pokemon_get_new_skill_id = @@pokemon_attack.id
                        # @battle.change_skill = true
                        # @battle.get_new_skill= true
                        # @battle.skills_slot_full = true

                        @battle.header_message = @@pokemon_attack.name.titleize+" level up and Get new skill "+@new_skill.name.titleize
                        @battle.save

                        # message = @@pokemon_attack.name+" Level Up and Get new skill "+@new_skill.name
                        # flash[:notice] = message.titleize 
                    end 
                    
                    if $skills.length != 0

                        @battle.skill_id = $skills.shift
                        @battle.pokemon_get_new_skill_id = @@pokemon_attack.id
                        # @battle.change_skill = true
                        @battle.get_new_skill= true
                        @battle.skills_slot_full = true
                        @battle.save
                    else
                        @battle.skill_id = nil
                        @battle.pokemon_get_new_skill_id = nil
                        # @battle.change_skill = true
                        @battle.get_new_skill= false
                        @battle.skills_slot_full = true
                        @battle.save

                    end
                end
                # End
            elsif exp_winner < @@pokemon_attack.pokemon_max_exp
                # puts "mask sini kakak"
                
                @battle.winner_hp = @@pokemon_attack.pokemon_hp
                @battle.winner_level_old = @@pokemon_attack.level
                @battle.winner_max_hp = @@pokemon_attack.pokemon_max_hp
                @battle.loser_hp = @@pokemon_got_damage.pokemon_hp
                @battle.loser_max_hp = @@pokemon_got_damage.pokemon_max_hp
                @battle.loser_level = @@pokemon_got_damage.level
                @battle.winner_exp = @@pokemon_attack.pokemon_exp
                @battle.winner_max_exp = @@pokemon_attack.pokemon_max_exp
                @battle.winner_exp_plus = @exp_calculation
                @battle.winner_attack_old = @@pokemon_attack.pokemon_attack
                @battle.winner_defence_old = @@pokemon_attack.pokemon_defence
                @battle.winner_special_old = @@pokemon_attack.pokemon_special
                @battle.winner_speed_old = @@pokemon_attack.pokemon_speed
                @battle.save
                
                @@pokemon_attack.pokemon_exp = exp_winner
                @@pokemon_attack.save
            end
            # puts "ini di luar"
            @battle.save
            
        else
            # Change Attacker
            @battle.attacker_name = @@pokemon_attack.name
            @battle.defender_name = @@pokemon_got_damage.name
            @battle.attacker_skill_name = @@pokemon_skill.skill.name
            @battle.attacker_total_damage = damage
            @battle.current_attacker_id = @@pokemon_got_damage.id
            @battle.header_message = "Current attacker is "+@battle.current_attacker.name.titleize
            @battle.save
            
        end
        # End


        # End
        redirect_to battle_path
    end

    def exp_calculation
        pokemon_attack_level = @@pokemon_attack.level
        pokemon_defence_level = @@pokemon_got_damage.level
        exp = 0.0
        if pokemon_attack_level < pokemon_defence_level
            exp = BASE_EXP + ((pokemon_defence_level - pokemon_attack_level)* EXP_BONUS)
            exp.round.to_i
        elsif pokemon_attack_level > pokemon_defence_level
            exp = BASE_EXP - ((pokemon_attack_level - pokemon_defence_level)* EXP_PUNISH)
            exp.round.to_i
        else
            exp = BASE_EXP.to_i
        end
    end
    

    def level_up
        pokemon_level = @@pokemon_attack.level
        max_exp = $max_exp[pokemon_level]
        curr_exp = @@pokemon_attack.pokemon_exp + exp_calculation()
        # puts "curr exp : ", curr_exp
        # iteration = 0

        attack_plus = 0
        defence_plus = 0
        speed_plus = 0
        special_plus = 0
        hp_plus=0
        level_plus = 0
        while curr_exp >= max_exp
            @@pokemon_attack.level = @@pokemon_attack.level + 1

            new_skill = Skill.where("level = ?  and  element = ? or level = ?  and  element = ? ", @@pokemon_attack.level,@@pokemon_attack.pokedex.element_1, @@pokemon_attack.level,@@pokemon_attack.pokedex.element_2 )

            if new_skill.length != 0
                # puts "nambah skill"
                for x  in 0..(new_skill.length-1)
                    $skills.push(new_skill[x].id)
                end
            end
            attack_rand = rand(5..9)
            defence_rand = rand(5..9)
            speed_rand = rand(5..9)
            special_rand = rand(5..9)
            hp_rand = rand(5..9)

            attack_plus += attack_rand
            defence_plus += defence_rand
            speed_plus += speed_rand
            special_plus += special_rand
            hp_plus += hp_rand
            level_plus += 1

            
            @@pokemon_attack.pokemon_attack = @@pokemon_attack.pokemon_attack + attack_rand
            @@pokemon_attack.pokemon_defence = @@pokemon_attack.pokemon_defence + defence_rand
            @@pokemon_attack.pokemon_speed = @@pokemon_attack.pokemon_speed + speed_rand
            @@pokemon_attack.pokemon_special = @@pokemon_attack.pokemon_special + special_rand
            @@pokemon_attack.pokemon_max_hp = @@pokemon_attack.pokemon_max_hp + hp_rand
            @@pokemon_attack.pokemon_hp = @@pokemon_attack.pokemon_hp + hp_rand
            @@pokemon_attack.pokemon_exp = curr_exp - max_exp
            @@pokemon_attack.pokemon_max_exp = $max_exp[pokemon_level+1]
            @@pokemon_attack.save

            curr_exp -= max_exp
            pokemon_level += 1
            max_exp = $max_exp[pokemon_level]
        end
        arr = Array.new
        arr.push(attack_plus, defence_plus, special_plus, speed_plus, hp_plus, level_plus)
        arr
    end

    def change_skill_state
        # puts "ganti babang"
        @battle = Battle.find(params[:id])
        @battle.change_skill = true
        @battle.header_message = @@pokemon_attack.name.titleize+", select the skill you want to change"
        @battle.save
        # puts @battle.id


        # flash[:notice] = message
        redirect_to battle_path
    end
    
    def dont_change_or_add_skill_state
        # puts "gak ganti babang"
        @battle = Battle.find(params[:id])
        if $skills.length != 0
            skill = $skills.shift
            # puts skill
            @battle.skill_id = skill
            @battle.pokemon_get_new_skill_id = params[:pokemon_id]
            @battle.change_skill = false
            @battle.get_new_skill= true

            if @@pokemon_attack.pokemon_skills.count >= 4
                @battle.skills_slot_full = true
            end
        else
            @battle.get_new_skill = false
            @battle.change_skill = false
            @battle.skill_id = nil
            @battle.game_over = true    
        end

        @battle.header_message = @@pokemon_attack.name.titleize+" skills are not exchanged"
        @battle.save

        # flash[:notice] = message
        redirect_to battle_path
    end
    
    def change_skill
        # puts "masuk ke change skill"
        # puts params[:pokemon_id]
        # puts params[:pokemon_skill_id]

        @battle = Battle.find(params[:battle_id])
        @pokemon_skill = PokemonSkill.find(params[:pokemon_skill_id])

        @pokemon_skill.skill_id = @battle.skill_id
        @pokemon_skill.last_pp = @battle.skill.pp
        @pokemon_skill.save

        if $skills.length != 0
            skill = $skills.shift
            # puts skill
            @battle.skill_id = skill
            @battle.pokemon_get_new_skill_id = params[:pokemon_id]
            @battle.change_skill = false
            @battle.get_new_skill= true

            if @@pokemon_attack.pokemon_skills.count >= 4
                @battle.skills_slot_full = true
            end
        else
            @battle.get_new_skill = false
            @battle.change_skill = false
            @battle.skill_id = nil
            @battle.game_over = true    
        end

        @battle.header_message = @@pokemon_attack.name+", Skill Successfully Changed" 
        @battle.save

        redirect_to  battle_path
    end
    
    def add_skill
        @battle = Battle.find(params[:id])
        @pokemon_skill = PokemonSkill.new
        @pokemon_skill.pokemon_id = @battle.winner_id
        @pokemon_skill.skill_id = @battle.skill_id
        @pokemon_skill.last_pp = @battle.skill.pp
        @pokemon_skill.save

        if $skills.length != 0
            skill = $skills.shift
            # puts skill
            @battle.skill_id = skill
            @battle.pokemon_get_new_skill_id = params[:pokemon_id]
            @battle.change_skill = false
            @battle.get_new_skill= true

            if @battle.winner.pokemon_skills.count >= 4
                @battle.skills_slot_full = true
            end
        else
            @battle.get_new_skill = false
            @battle.change_skill = false
            @battle.skill_id = nil
            @battle.game_over = true    
        end

        @battle.save
        redirect_to battle_path
    end
    
    
    def damage_calculation
        multipier = $element_chart[@@pokemon_attack.pokedex.element_1][@@pokemon_got_damage.pokedex.element_1]
        hasil = (@@pokemon_attack.pokemon_attack.to_f  + @@pokemon_skill.skill.power.to_f - @@pokemon_got_damage.pokemon_defence.to_f)  * multipier
        if hasil < 0 
            hasil = 0
        end
        hasil.to_i
    end
    
    def hp_check
        @@pokemon_got_damage.pokemon_hp == 0 ? true : false
    end

    def pp_check
        skills_pp = @@pokemon_got_damage.pokemon_skills.all? {|pokemon_skill| pokemon_skill.last_pp == 0}
        skills_pp
    end
    

    def battle_params
        params.require(:battle).permit(:pokemon_i_id, :pokemon_ii_id)
    end

    def battle_detail_params
        params.require(:battle_detail).permit(:battle_id, :pokemon_id, :skill_id)
    end
    
    
end
