Rails.application.routes.draw do
  resources :tutoring_sessions
  resources :event_tutors
  resources :events
  resources :tutors
  resources :cities
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
