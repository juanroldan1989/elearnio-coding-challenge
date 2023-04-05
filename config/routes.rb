Rails.application.routes.draw do
  namespace :v1 do
    resources :authors
    resources :courses
    resources :talents
  end
end
