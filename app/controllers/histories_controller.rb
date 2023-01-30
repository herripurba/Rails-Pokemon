class HistoriesController < ApplicationController
    def index
        @histories = Battle.all.order(id: :asc)
    end

    def show
        @battle = Battle.find(params[:id])
        @histories = @battle.battle_details.order(id: :asc)
    end
    
    
end
