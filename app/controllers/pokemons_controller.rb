class PokemonsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @pokemons = Pokemon.where("is_delete = ?", "false").order(id: :asc)
    end
    
    def new
        @pokemon = Pokemon.new
        @pokedexes = Pokedex.all.order(id: :asc)
    end

    def show
        @pokemon = Pokemon.find(params[:id])
        @pokedex = Pokedex.find(@pokemon.pokedex_id)
        @pokemon_skills = @pokemon.pokemon_skills.order(id: :asc)
    end
    

    def create
        # require 'pry'
        
        # binding.pry
        
        @pokemon = Pokemon.new(pokemon_params)
        if @pokemon.pokedex_id == 0 || @pokemon.name == ""
            if @pokemon.save ==false
                puts "masuk ke pokedex id"
                # @pokemon = Pokemon.new
                @pokedexes = Pokedex.all
                render :new, status: :unprocessable_entity
            end
        else
            @pokedex = Pokedex.find(@pokemon.pokedex_id)
            @initiate_skills = @pokedex.skills
    
            @pokemon.pokemon_attack = @pokedex.attack
            @pokemon.pokemon_defence = @pokedex.defence
            @pokemon.pokemon_speed = @pokedex.speed
            @pokemon.pokemon_special = @pokedex.special 
            @pokemon.pokemon_max_exp = @pokedex.max_exp
            @pokemon.pokemon_max_hp = @pokedex.max_hp
            @pokemon.pokemon_hp = @pokedex.max_hp
            
            if @pokemon.save
                
                @initiate_skills.each do |skill|
                    @pokemon_skill = PokemonSkill.new
                    @pokemon_skill.pokemon_id = @pokemon.id
                    @pokemon_skill.skill_id = skill.id
                    @pokemon_skill.last_pp = skill.pp
    
                    @pokemon_skill.save
                end
                
                flash[:success] = "Pokemon created successfully"
                redirect_to pokemon_path(@pokemon)
            else
    
                @pokemon = Pokemon.new
                @pokedexes = Pokedex.all
                render :new, status: :unprocessable_entity
            end
        end
    end

    
    def delete_pokemon
        @pokemon = Pokemon.find(params[:id_pokemon])
        # binding.pry 
        battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", params[:id], params[:id]])
        
        # require 'pry'
        # binding.pry
        if @pokemon.status != "In Battle"
            if battles.length == 0
                @pokemon.destroy
            else
                @pokemon.is_delete = true
                @pokemon.save
            end
        end
        
        flash[:success] = "Pokemon deleted successfully"
        redirect_to pokemons_path
    end
    
    def heal
        @pokemon = Pokemon.find(params[:id_pokemon])
        @pokemon_skills = @pokemon.pokemon_skills
        
        if @pokemon.status != "In Battle"
            @pokemon.pokemon_hp = @pokemon.pokemon_max_hp
            @pokemon.status = "Free"
            @pokemon.save
            
            @pokemon_skills.each do |pokemon_skill|
                puts pokemon_skill.last_pp
                puts pokemon_skill.skill.pp
                pokemon_skill.last_pp = pokemon_skill.skill.pp
                pokemon_skill.save
            end
            
            flash[:success] = "Pokemon Successfully Healed"
            redirect_to pokemon_path
        
        else
            # errors.add(@pokemon, "Pokemon Sedang dalam battle")
            @pokemon = Pokemon.find(params[:id])
            @pokedex = Pokedex.find(@pokemon.pokedex_id)
            @pokemon_skills = @pokemon.pokemon_skills
            render :show, status: :unprocessable_entity

        end
        
    end
    
    private
    def pokemon_params
        params.require(:pokemon).permit(:name, :pokedex_id)
    end
    
end
