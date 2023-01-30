class CreateBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.references :pokemon_i, null: false, foreign_key: { to_table: :pokemons } 
      t.references :pokemon_ii, null: false, foreign_key: { to_table: :pokemons }
      t.references :winner, null: true, foreign_key: { to_table: :pokemons }
      t.references :current_attacker, null: true, foreign_key: { to_table: :pokemons }
      t.boolean :level_up, default: false
      t.references :pokemon_level_up, null: true, foreign_key: { to_table: :pokemons }
      t.boolean :get_new_skill, default: false
      t.boolean :change_skill, default: false
      t.belongs_to :skill, null: true
      t.references :pokemon_get_new_skill, null: true, foreign_key: { to_table: :pokemons }
      t.boolean :skills_slot_full, default: false
      t.boolean :game_over, default: false
      
      t.datetime :battle_date
      t.string :status, default: "In Battle"
      t.string :header_message, null: true

      t.string :attacker_name
      t.string :defender_name
      t.string :attacker_skill_name
      t.integer :attacker_total_damage

      t.integer :winner_hp, null: true
      t.integer :winner_level_old, null: true
      t.integer :winner_level_plus, null: true
      t.integer :winner_max_hp,  null: true
      t.integer :winner_hp_plus,  null: true
      t.integer :winner_exp, null: true
      t.integer :winner_max_exp, null: true
      t.integer :winner_exp_plus, null: true
      t.integer :loser_hp, null: true
      t.integer :loser_max_hp, null: true
      t.integer :loser_level, null: true
      t.integer :winner_attack_old, null: true
      t.integer :winner_attack_plus, null: true
      t.integer :winner_defence_old, null: true
      t.integer :winner_defence_plus, null: true
      t.integer :winner_speed_old, null: true
      t.integer :winner_speed_plus, null: true
      t.integer :winner_special_old, null: true
      t.integer :winner_special_plus, null: true

      

      t.timestamps
    end
    # add_foreign_key :battles, :pokemons, column: :pokemon1_id
    # add_foreign_key :battles, :pokemons, column: :pokemon2_id
    # add_foreign_key :battles, :pokemons, column: :winner  
  end
end
