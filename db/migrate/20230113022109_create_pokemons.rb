class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.belongs_to :pokedex
      t.string :name
      t.integer :pokemon_hp, default: 0
      t.integer :pokemon_max_hp, default: 0
      t.integer :pokemon_attack, default: 0
      t.integer :pokemon_defence, default: 0
      t.integer :pokemon_speed, default: 0
      t.integer :pokemon_special, default: 0
      t.integer :level, default: 1
      t.integer :pokemon_max_exp, default: 0
      t.integer :pokemon_exp, default: 0
      t.boolean :is_delete, default: false
      t.string :status, default: "Free"

      t.timestamps
    end
  end
end
