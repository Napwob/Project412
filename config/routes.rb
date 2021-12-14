# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :slots

  root to: 'home#index'
  get '/game', to: 'game#index'
  get '/help', to: 'game#help'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'go_job' => 'game#go_job'
  get 'contemplate_nature' => 'game#contemplate_nature'
  get 'drink_wine_and_watch_tv_series' => 'game#drink_wine_and_watch_tv_series'
  get 'go_to_the_bar' => 'game#go_to_the_bar'
  get 'drink_with_marginal_people' => 'game#drink_with_marginal_people'
  get 'sing_in_the_subway' => 'game#sing_in_the_subway'
  get 'sleep' => 'game#sleep'
  get 'new_game' => 'game#new_game'
  post 'load_game' => 'slots#load_game'
end
