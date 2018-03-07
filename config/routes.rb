Rails.application.routes.draw do
  resources :todos, only: [:create, :index, :destroy]
end
