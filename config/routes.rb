Rails.application.routes.draw do
  devise_for :users
  root "dashboard#index", as:'homepage'
  get 'main/about'
end
