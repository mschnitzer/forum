Rails.application.routes.draw do
  root 'boards#index'

  get '/boards/:board', to: 'boards#show', as: :boards_show

  get '/users/register', to: 'users#new', as: :users_new
  post '/users/register', to: 'users#register'
end
