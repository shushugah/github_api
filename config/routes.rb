Rails.application.routes.draw do
  root 'repositories#search'
  get 'repositories/index'
  get '/auth' => 'sessions#create'
end
