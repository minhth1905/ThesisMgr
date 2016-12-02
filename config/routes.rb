Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  get "home" => "static_pages#index"
  devise_for :users

  namespace :admin do
    resources :departmentusers do
      collection { post :import }
    end
    resources :courses
    resources :trainings
    resources :teachers do
      collection { post :import }
    end
    resources :spheres
  end
end
