class Pokedex < ApplicationRecord
    has_many :pokemons
    has_many :initiate_skills
    has_many :skills, :through => :initiate_skills
end
