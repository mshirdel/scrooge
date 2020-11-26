Rails.application.routes.draw do
  root "dashboard#index", as:'homepage'
  scope '/dashboard' do
    resources :groups
    resources :tags
    resources :items
  end
  
  devise_for :users

end
