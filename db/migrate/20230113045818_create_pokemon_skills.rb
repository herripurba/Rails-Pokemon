class CreatePokemonSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon_skills do |t|
      t.belongs_to :pokemon
      t.belongs_to :skill
      t.integer :last_pp
      t.timestamps
    end
  end
end
