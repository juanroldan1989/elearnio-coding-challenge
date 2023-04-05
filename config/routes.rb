Rails.application.routes.draw do
  namespace :v1 do
    resources :authors
    resources :courses
    resources :learning_paths
    resources :talents
  end
end
