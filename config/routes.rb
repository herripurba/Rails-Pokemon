Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :pokemons do
    post :heal, on: :member
    post :delete_pokemon, on: :member
  end

  resources :pokedexs, only: [:index, :show]

  resources :battles do
    post :attack, on: :member
    post :change_skill_state, on: :member
    post :change_skill, on: :member
    post :add_skill, on: :member
    # post :dont_add_skill, on: :member
    post :dont_change_or_add_skill_state, on: :member
  end
  
  resources :histories, only: [:index, :show]


end
