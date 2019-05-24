Rails.application.routes.draw do
  root 'repositories#search'
  get 'repositories/index'
  get 'sessions/delete'
  get 'application/authenticate_user', as: 'login'
  get '/auth' => 'sessions#create'
end
