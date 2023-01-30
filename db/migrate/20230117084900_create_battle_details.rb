class CreateBattleDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_details do |t|
      t.belongs_to :battle
      t.belongs_to :pokemon
      t.belongs_to :skill
      t.string :message
      t.integer :damage
      t.integer :enemy_hp
      t.timestamps
    end
  end
end
