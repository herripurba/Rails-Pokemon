class Skill < ApplicationRecord
    # before_update :update_power
    has_many :initiate_skills
    has_many :pokedexes, :through => :initiate_skills
    has_many :pokemon_skills, dependent: :destroy
    has_many :pokemons, :through => :pokemon_skills

    has_one :battle


    validate :update_power, on: :update
    validate :update_pp, on: :update

    private
    def update_power
        if self.power != nil
            # puts "power gak bisa ganti babang"
            errors.add(:id, "Skills power cant be updated")
        end
    end
    def update_pp
        if self.pp != nil
            # puts "power gak bisa ganti babang"
            errors.add(:id, "Skills pp cant be updated")
        end
    end
    
end
