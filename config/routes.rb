Rails.application.routes.draw do
  root 'boards#index'

  get '/boards/:board', to: 'boards#show', as: :boards_show

  get '/boards/:board/threads/new', to: 'board_threads#new', as: :board_threads_new
  post '/boards/:board/threads/new', to: 'board_threads#create', as: :board_threads_create
  get '/boards/:board/threads/:thread', to: 'board_threads#show', as: :board_threads_show
  post '/boards/:board/threads/:thread/posts/new', to: 'board_thread_posts#create', as: :board_thread_posts_create

  get '/users/register', to: 'users#new', as: :users_new
  post '/users/register', to: 'users#register'
  get '/users/logout', to: 'users#logout'
  get '/users/login', to: 'users#login'
  post '/users/login', to: 'users#login_perform', as: :users_login_perform
end
