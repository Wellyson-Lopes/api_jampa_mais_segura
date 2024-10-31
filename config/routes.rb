Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, path: "admin", controllers: {
    sessions: "admins/sessions",
    registrations: "admins/registrations"
  }
  root "admins/home#index"

  namespace :api do
    namespace :v1 do
      post "login", to: "users#login"
      post "users", to: "users#create"
      patch "users/update", to: "users#update"
      delete "users/delete", to: "users#destroy"

      namespace :incidents do
        get "list", to: "incidents#index"
        get "list_of_crime_types", to: "incidents#list_of_crime_types"
        post "new", to: "incidents#create"
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
