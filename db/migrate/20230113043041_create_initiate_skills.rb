class CreateInitiateSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :initiate_skills do |t|
      t.belongs_to :pokedex
      t.belongs_to :skill

      t.timestamps
    end
  end
end
