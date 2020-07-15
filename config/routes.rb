Rails.application.routes.draw do
  root to: 'application#index'

  resource :games, only: [:create, :show]
end
