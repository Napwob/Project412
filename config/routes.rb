# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get '/game', to: 'game#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  post 'go_job' => 'game#go_job'
  post 'new_game' => 'game#new_game'
end
