Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "welcome#index"

  resources :recipes do
    # Ensure the "count" route is set up first
    collection do
      get "count" # By using collection, Rails knows /recipes/count is an action
      # on the collection of recipes, not a request for a recipe with the ID
      # "count," and thus handles it correctly before moving on to the
      # dynamic :id routes.
    end
  end
end
