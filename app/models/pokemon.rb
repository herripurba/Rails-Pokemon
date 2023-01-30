class Pokemon < ApplicationRecord
    # before_destroy :pokemon_has_battle

    before_create :pokedex_not_nil_validation

    belongs_to :pokedex, optional: true
    has_many :battle_details
    has_many :pokemon_skills ,dependent: :destroy
    has_many :skills, :through => :pokemon_skills

    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_i_id'
    has_many :battles, class_name:'Battle',  foreign_key:'pokemon_ii_id'
    has_many :battles, class_name:'Battle',  foreign_key:'winner_id'
    has_many :battles, class_name:'Battle',  foreign_key:'current_attacker_id'

    validates :pokemon_hp, numericality: { greater_than_or_equal_to: 0 }
    # validates :pokedex, :message => "Pokemon type must exist"
    # validates :name, presence: true
    validates_presence_of :name, :message => "Pokemon name must exist"
    validate :pokedex_not_nil_validation, on: :create
    validate :pokemon_has_battle, on: :destroy
    validate :pokemon_in_battle, on: :destroy
    # validate :heal_validation, on: :update


    private
    
    def name_and_pokedex
        if self.name == nil && self.pokedex_id == 0
            errors.add(:id, "Name can't nil")
            errors.add(:id, "Please select pokemon type")
        elsif self.name == nil
            errors.add(:id, "Name can't nil")
        elsif self.pokedex_id == 0
            errors.add(:id, "Please select pokemon type")
        end
    end

    def pokemon_in_battle
        @pokemon = Pokemon.find(self.id)
        if @pokemon.status == "In Battle"
            errors.add(:id, "Pokemon can't deleted because pokemon in a battle")
        end
    end
    
    def pokemon_has_battle        
        @pokemon = Pokemon.find(self.id)
        battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.id, self.id])
        battles_check = battles.any? {|battle| battle.status == "In Battle"}
        if battles_check
            errors.add(:id, "Pokemon can't deleted")
        end

    end
    

    def pokedex_not_nil_validation
        # puts pokedex_id
        if pokedex_id == 0
            errors.add(:pokedex_id, "Pokemon type must exist")
        end
    end


    # def heal_validation
    #     @pokemon = Pokemon.find(self.id)
    #     battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.id, self.id])
    #     battles_check = battles.any? {|battle| battle.status == "In Battle"}
    #     if battles_check && @po
    #         errors.add(:id, "Pokemon can't be healed because it is in battle")
    #     end
    # end
    
    # def destroy_battle
    #     battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.id, self.id])
        
    #     battles.each do |battle|
    #         battle.destroy
    #     end
    # end
    # def check_pokemon_in_battle
    #     pokemon = Pokemon.find(self.id)
    # end
    
    # def check_pokemon_in_battle
    #     battles = Battle.where(["pokemon_i_id = ?  or pokemon_ii_id = ?", self.id, self.id])
    #     battles_check = battles.any? {|battle| battle.status == "In Battle"}
    #     if battles_check
    #         errors.add(:id, "Pokemon can't update because pokemon is in battle")
    #     end
    # end
    
end
