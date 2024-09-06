Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      resources :users
      resources :foods
      resources :favorites
      resources :claims
    end
  end
  post "/login", to: "api/v1/users#login"
end
