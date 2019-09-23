Rails.application.routes.draw do
  devise_for :users
  resources :items
  resources :mypages, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "users/sign_up" => "users#sign_up"
  get "users/registration" => "users#registration"
  get "users/sms_confirmation" => "users#sms_confirmation"
  get "users/address" => "users#address"
  get "users/credit" => "users#credit"
  get "users/complete" => "users#complete"
  get "users/log_in" => "users#log_in"

  root 'items#index'
end
