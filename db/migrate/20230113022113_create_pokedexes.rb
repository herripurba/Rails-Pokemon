class CreatePokedexes < ActiveRecord::Migration[7.0]
  def change
    create_table :pokedexes do |t|
      t.string :name
      t.integer :max_hp
      t.integer :max_exp
      t.integer :attack
      t.integer :defence
      t.integer :speed
      t.integer :special
      t.integer :level, default: 1
      t.string :element_1
      t.string :element_2
      t.string :image

      t.timestamps
    end
  end
end
