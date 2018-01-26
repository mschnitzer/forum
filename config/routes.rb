Rails.application.routes.draw do
  root 'boards#index'

  get '/boards/:board', to: 'boards#show', as: :boards_show

  get '/boards/:board/threads/new', to: 'board_threads#new', as: :board_threads_new
  post '/boards/:board/threads/new', to: 'board_threads#create', as: :board_threads_create

  get '/users/register', to: 'users#new', as: :users_new
  post '/users/register', to: 'users#register'
end
