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
    resources :departmentusers
    resources :courses
    resources :trainings
  end
end
