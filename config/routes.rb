# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :all

  namespace :api do
    post 'register', to: 'users#register'
    post 'login', to: 'users#login'
    get 'users/:id', to: 'users#show'
  end
end
