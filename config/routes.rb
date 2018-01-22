Rails.application.routes.draw do
  root 'boards#index'

  get '/boards/:id/:name', to: 'boards#show', as: :boards_show
end
