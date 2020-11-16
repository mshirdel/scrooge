Rails.application.routes.draw do
  root 'main#index', as: 'homepage'
  get 'main/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
