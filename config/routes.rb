Rails.application.routes.draw do
  root 'boards#index'

  get '/boards/:board', to: 'boards#show', as: :boards_show
end
