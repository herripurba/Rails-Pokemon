# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_17_084900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battle_details", force: :cascade do |t|
    t.bigint "battle_id"
    t.bigint "pokemon_id"
    t.bigint "skill_id"
    t.string "message"
    t.integer "damage"
    t.integer "enemy_hp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_battle_details_on_battle_id"
    t.index ["pokemon_id"], name: "index_battle_details_on_pokemon_id"
    t.index ["skill_id"], name: "index_battle_details_on_skill_id"
  end

  create_table "battles", force: :cascade do |t|
    t.bigint "pokemon_i_id", null: false
    t.bigint "pokemon_ii_id", null: false
    t.bigint "winner_id"
    t.bigint "current_attacker_id"
    t.boolean "level_up", default: false
    t.bigint "pokemon_level_up_id"
    t.boolean "get_new_skill", default: false
    t.boolean "change_skill", default: false
    t.bigint "skill_id"
    t.bigint "pokemon_get_new_skill_id"
    t.boolean "skills_slot_full", default: false
    t.boolean "game_over", default: false
    t.datetime "battle_date"
    t.string "status", default: "In Battle"
    t.string "header_message"
    t.string "attacker_name"
    t.string "defender_name"
    t.string "attacker_skill_name"
    t.integer "attacker_total_damage"
    t.integer "winner_hp"
    t.integer "winner_level_old"
    t.integer "winner_level_plus"
    t.integer "winner_max_hp"
    t.integer "winner_hp_plus"
    t.integer "winner_exp"
    t.integer "winner_max_exp"
    t.integer "winner_exp_plus"
    t.integer "loser_hp"
    t.integer "loser_max_hp"
    t.integer "loser_level"
    t.integer "winner_attack_old"
    t.integer "winner_attack_plus"
    t.integer "winner_defence_old"
    t.integer "winner_defence_plus"
    t.integer "winner_speed_old"
    t.integer "winner_speed_plus"
    t.integer "winner_special_old"
    t.integer "winner_special_plus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["current_attacker_id"], name: "index_battles_on_current_attacker_id"
    t.index ["pokemon_get_new_skill_id"], name: "index_battles_on_pokemon_get_new_skill_id"
    t.index ["pokemon_i_id"], name: "index_battles_on_pokemon_i_id"
    t.index ["pokemon_ii_id"], name: "index_battles_on_pokemon_ii_id"
    t.index ["pokemon_level_up_id"], name: "index_battles_on_pokemon_level_up_id"
    t.index ["skill_id"], name: "index_battles_on_skill_id"
    t.index ["winner_id"], name: "index_battles_on_winner_id"
  end

  create_table "initiate_skills", force: :cascade do |t|
    t.bigint "pokedex_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokedex_id"], name: "index_initiate_skills_on_pokedex_id"
    t.index ["skill_id"], name: "index_initiate_skills_on_skill_id"
  end

  create_table "pokedexes", force: :cascade do |t|
    t.string "name"
    t.integer "max_hp"
    t.integer "max_exp"
    t.integer "attack"
    t.integer "defence"
    t.integer "speed"
    t.integer "special"
    t.integer "level", default: 1
    t.string "element_1"
    t.string "element_2"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_skills", force: :cascade do |t|
    t.bigint "pokemon_id"
    t.bigint "skill_id"
    t.integer "last_pp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokemon_id"], name: "index_pokemon_skills_on_pokemon_id"
    t.index ["skill_id"], name: "index_pokemon_skills_on_skill_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.bigint "pokedex_id"
    t.string "name"
    t.integer "pokemon_hp", default: 0
    t.integer "pokemon_max_hp", default: 0
    t.integer "pokemon_attack", default: 0
    t.integer "pokemon_defence", default: 0
    t.integer "pokemon_speed", default: 0
    t.integer "pokemon_special", default: 0
    t.integer "level", default: 1
    t.integer "pokemon_max_exp", default: 0
    t.integer "pokemon_exp", default: 0
    t.boolean "is_delete", default: false
    t.string "status", default: "Free"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pokedex_id"], name: "index_pokemons_on_pokedex_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "pp"
    t.integer "power"
    t.integer "level"
    t.string "element"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "battles", "pokemons", column: "current_attacker_id"
  add_foreign_key "battles", "pokemons", column: "pokemon_get_new_skill_id"
  add_foreign_key "battles", "pokemons", column: "pokemon_i_id"
  add_foreign_key "battles", "pokemons", column: "pokemon_ii_id"
  add_foreign_key "battles", "pokemons", column: "pokemon_level_up_id"
  add_foreign_key "battles", "pokemons", column: "winner_id"
end
