# # config/routes.rb

Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :employee_registrations, only: %i[new create]
  get '/get_coaches', to: 'employee_registrations#get_coaches'
  get 'employee_coaching', to: 'employee_coaching#index'

  get 'coach_dashboard', to: 'coaches#index', as: 'coach_dashboard'
  get 'coach_dashboard/filter_sessions', to: 'coaches#filter_sessions', as: 'filter_sessions_coach_dashboard'
end
