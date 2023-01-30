class BattleDetail < ApplicationRecord
    belongs_to :battle
    belongs_to :pokemon
    belongs_to :skill
end
