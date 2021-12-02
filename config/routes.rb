# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :slots

  root to: 'home#index'
  get '/game', to: 'game#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'go_job' => 'game#go_job'
  post 'contemplate_nature' => 'game#contemplate_nature'
  post 'drink_wine_and_watch_tv_series' => 'game#drink_wine_and_watch_tv_series'
  post 'go_to_the_bar' => 'game#go_to_the_bar'
  post 'drink_with_marginal_people' => 'game#drink_with_marginal_people'
  post 'sing_in_the_subway' => 'game#sing_in_the_subway' 
  post 'sleep' => 'game#sleep'
  post 'new_game' => 'game#new_game'
end
