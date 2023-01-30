# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


BattleDetail.destroy_all
Battle.destroy_all
InitiateSkill.destroy_all
Pokedex.destroy_all
PokemonSkill.destroy_all
Skill.destroy_all
Pokemon.destroy_all

Pokedex.create!([{
    name: "Charmander",
    max_hp: 39,
    max_exp: 100,
    attack: 52,
    defence: 43,
    speed: 65,
    special: 50,
    element_1: "Fire",
    element_2: nil,
    image: "004Charmander.png"
},
{
    name: "Bulbasaur",
    max_hp: 45,
    max_exp: 100,
    attack: 49,
    defence: 49,
    speed: 45,
    special: 65,
    element_1: "Grass",
    element_2: nil,
    image:"001Bulbasaur.png"
},
{
    name: "Squirtle",
    max_hp: 44,
    max_exp: 100,
    attack: 48,
    defence: 65,
    speed: 43,
    special: 50,
    element_1: "Water",
    element_2: nil,
    image: "007Squirtle.png"
},
{
    name: "Pidgey",
    max_hp: 40,
    max_exp: 100,
    attack: 45,
    defence: 40,
    speed: 56,
    special: 35,
    element_1: "Normal",
    element_2: nil,
    image: "016Pidgey.png"  
},
])

p "Created #{Pokedex.count} Pokedex"

Skill.create!([{
    name: "Fire Punch",
    element: "Fire",
    pp: 15,
    power: 18,
    level: 1,
},
{
    name: "Flamethrower",
    element: "Fire",
    pp: 15,
    power: 12,
    level: 1,
},
{
    name: "Fire Spin 1",
    element: "Fire",
    pp: 15,
    power: 15,
    level: 3,
},
{
    name: "Fire Spin 2",
    element: "Fire",
    pp: 15,
    power: 15,
    level: 5,
},
{
    name: "Fire Blast",
    element: "Fire",
    pp: 5,
    power: 60,
    level: 20,
},
{
    name: "Flame Wheel",
    element: "Fire",
    pp: 25,
    power: 5,
    level: 10,
},
{
    name: "Sacred Fire",
    element: "Fire",
    pp: 5,
    power: 100,
    level: 15,
},
{
    name: "Vine Whip",
    element: "Grass",
    pp: 7,
    power: 25,
    level: 1,
},
{
    name: "Leech Seed",
    element: "Grass",
    pp: 15,
    power: 15,
    level: 1,
},
{
    name: "Razor Leaf",
    element: "Grass",
    pp: 18,
    power: 12,
    level: 1,
},
{
    name: "Sleep Powder",
    element: "Grass",
    pp: 10,
    power: 20,
    level: 1,
},
{
    name: "Seed Bomb",
    element: "Grass",
    pp: 10,
    power: 20,
    level: 5,
},
{
    name: "Synthesis",
    element: "Grass",
    pp: 10,
    power: 50,
    level: 15,
},
{
    name: "Worry Seed",
    element: "Grass",
    pp: 10,
    power: 50,
    level: 20,
},
{
    name: "Water Gun",
    element: "Water",
    pp: 15,
    power: 18,
    level: 1,
},
{
    name: "Withdraw",
    element: "Water",
    pp: 18,
    power: 12,
    level: 1,
},
{
    name: "Water Pulse",
    element: "Water",
    pp: 18,
    power: 12,
    level: 1,
},
{
    name: "Rain Dance 1",
    element: "Water",
    pp: 5,
    power: 20,
    level: 3,
},
{
    name: "	Aqua Tail",
    element: "Water",
    pp: 10,
    power: 20,
    level: 5,
},
{
    name: "Rain Dance 2",
    element: "Water",
    pp: 5,
    power: 25,
    level: 10,
},
{
    name: "Hydro Pump",
    element: "Water",
    pp: 10,
    power: 50,
    level: 15,
},
{
    name: "Aqua Jet",
    element: "Water",
    pp: 10,
    power: 50,
    level: 20,
},
{
    name: "Tackle",
    element: "Normal",
    pp: 15,
    power: 18,
    level: 1,
},
{
    name: "Quick Attack",
    element: "Normal",
    pp: 18,
    power: 12,
    level: 1,
},
{
    name: "Whirlwind",
    element: "Normal",
    pp: 18,
    power: 12,
    level: 1,
},
{
    name: "Uproar",
    element: "Normal",
    pp: 10,
    power: 20,
    level: 5,
},
{
    name: "Work Up",
    element: "Normal",
    pp: 10,
    power: 50,
    level: 8,
},
{
    name: "Aqua Jet",
    element: "Normal",
    pp: 10,
    power: 50,
    level: 12,
},

{
    name: "Fire Spin 3",
    element: "Fire",
    pp: 15,
    power: 15,
    level: 5,
},
{
    name: "Fire Spin 4",
    element: "Fire",
    pp: 15,
    power: 15,
    level: 5,
},
{
    name: "Fire Spin 5",
    element: "Fire",
    pp: 15,
    power: 15,
    level: 5,
},

])

p "Created #{Skill.count} Skill"

InitiateSkill.create!([{
    pokedex_id: 1,
    skill_id: 1,
},
{
    pokedex_id: 1,
    skill_id: 2,
},
{
    pokedex_id: 2,
    skill_id: 8,
},
{
    pokedex_id: 2,
    skill_id: 9,
},
{
    pokedex_id: 2,
    skill_id: 10,
},
{
    pokedex_id: 2,
    skill_id: 11,
},
{
    pokedex_id: 3,
    skill_id: 14,
},
{
    pokedex_id: 3,
    skill_id: 15,
},
{
    pokedex_id: 3,
    skill_id: 16,
},
{
    pokedex_id: 4,
    skill_id: 21,
},
{
    pokedex_id: 4,
    skill_id: 22,
},
{
    pokedex_id: 4,
    skill_id: 23,
},
])

p "Created #{InitiateSkill.count} InitiateSkill"

# Battle.destroy_all

# Pokemon.destroy_all

Pokemon.create!([
{
    pokedex_id: 1,
    name: "Naga",
    pokemon_hp: 39,
    pokemon_max_hp: 39,
    pokemon_exp: 0,
    pokemon_max_exp: 100,
    level: 1,
    pokemon_attack: 52,
    pokemon_defence: 43,
    pokemon_speed: 65,
    pokemon_special: 50,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 1,
    name: "Naga2",
    pokemon_hp: 39,
    pokemon_max_hp: 39,
    pokemon_exp: 136,
    pokemon_max_exp: 150,
    level: 2,
    pokemon_attack: 52,
    pokemon_defence: 43,
    pokemon_speed: 65,
    pokemon_special: 50,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 2,
    name: "Racun darat",
    pokemon_hp: 45,
    pokemon_max_hp: 45,
    pokemon_exp: 0,
    pokemon_max_exp: 100,
    level: 1,
    pokemon_attack: 49,
    pokemon_defence: 49,
    pokemon_speed: 45,
    pokemon_special: 65,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 2,
    name: "Racun darat2",
    pokemon_hp: 45,
    pokemon_max_hp: 45,
    pokemon_exp: 240,
    pokemon_max_exp: 250,
    level: 4,
    pokemon_attack: 49,
    pokemon_defence: 49,
    pokemon_speed: 45,
    pokemon_special: 65,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 3,
    name: "Penyu",
    pokemon_hp: 44,
    pokemon_max_hp: 44,
    pokemon_exp: 0,
    pokemon_max_exp: 100,
    level: 1,
    pokemon_attack: 48,
    pokemon_defence: 65,
    pokemon_speed: 43,
    pokemon_special: 50,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 2,
    name: "Racun darat3",
    pokemon_hp: 45,
    pokemon_max_hp: 45,
    pokemon_exp: 240,
    pokemon_max_exp: 250,
    level: 4,
    pokemon_attack: 49,
    pokemon_defence: 49,
    pokemon_speed: 45,
    pokemon_special: 65,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 1,
    name: "Naga3",
    pokemon_hp: 39,
    pokemon_max_hp: 39,
    pokemon_exp: 240,
    pokemon_max_exp: 250,
    level: 4,
    pokemon_attack: 52,
    pokemon_defence: 43,
    pokemon_speed: 65,
    pokemon_special: 50,
    is_delete: false,
    status: "Free"
},
{
    pokedex_id: 1,
    name: "Naga4",
    pokemon_hp: 39,
    pokemon_max_hp: 39,
    pokemon_exp: 240,
    pokemon_max_exp: 250,
    level: 4,
    pokemon_attack: 52,
    pokemon_defence: 43,
    pokemon_speed: 65,
    pokemon_special: 50,
    is_delete: false,
    status: "Free"
},
])


p "Created #{Pokemon.count} Pokemon"

PokemonSkill.create!([
{
    pokemon_id: 1,
    skill_id: 1,
    last_pp: 15
},
{
    pokemon_id: 1,
    skill_id: 2,
    last_pp: 15
},
{
    pokemon_id: 2,
    skill_id: 1,
    last_pp: 15
},
{
    pokemon_id: 2,
    skill_id: 2,
    last_pp: 15
},
{
    pokemon_id: 3,
    skill_id: 8,
    last_pp: 7
},
{
    pokemon_id: 3,
    skill_id: 9,
    last_pp: 15
},
{
    pokemon_id: 3,
    skill_id: 10,
    last_pp: 18
},
{
    pokemon_id: 3,
    skill_id: 11,
    last_pp: 10
},
{
    pokemon_id: 4,
    skill_id: 8,
    last_pp: 7
},
{
    pokemon_id: 4,
    skill_id: 9,
    last_pp: 15
},
{
    pokemon_id: 4,
    skill_id: 10,
    last_pp: 18
},
{
    pokemon_id: 4,
    skill_id: 11,
    last_pp: 10
},
{
    pokemon_id: 5,
    skill_id: 15,
    last_pp: 14
},
{
    pokemon_id: 5,
    skill_id: 16,
    last_pp: 18
},
{
    pokemon_id: 6,
    skill_id: 8,
    last_pp: 7
},
{
    pokemon_id: 6,
    skill_id: 9,
    last_pp: 15
},
{
    pokemon_id: 6,
    skill_id: 10,
    last_pp: 18
},
{
    pokemon_id: 6,
    skill_id: 11,
    last_pp: 10
},
{
    pokemon_id: 7,
    skill_id: 1,
    last_pp: 15
},
{
    pokemon_id: 7,
    skill_id: 2,
    last_pp: 15
},
{
    pokemon_id: 7,
    skill_id: 3,
    last_pp: 15
},
{
    pokemon_id: 8,
    skill_id: 1,
    last_pp: 15
},
{
    pokemon_id: 8,
    skill_id: 2,
    last_pp: 15
}
])


p "Created #{PokemonSkill.count} PokemonSkill"