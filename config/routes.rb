Rails.application.routes.draw do
  resources :tutors
  resources :users

  root "/"
  get '/login_tutor', to: 'tutor_sessions#new',as: :login_tutor
  post '/login_tutor', to: 'tutor_sessions#create'

  get '/login_user', to: 'user_sessions#new',as: :login_user
  post '/login_user', to: 'user_sessions#create'
end
