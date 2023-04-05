Rails.application.routes.draw do
  namespace :v1 do
    resources :talents, only: [:create, :index, :update, :destroy]
  end
end
