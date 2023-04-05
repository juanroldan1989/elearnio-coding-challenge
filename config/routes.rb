Rails.application.routes.draw do
  namespace :v1 do
    resources :authors
    resources :courses
    resources :learning_paths
    resources :talents
    resources :talent_learning_path_courses, only: [:create, :update, :destroy]
  end
end
