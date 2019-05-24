Rails.application.routes.draw do
  root 'repositories#search'

  get '/auth' => 'sessions#create'
end
