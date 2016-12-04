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
    resources :labs
    resources :departments
    resources :subjects
    resources :students do
      collection { post :import }
    end
    resources :teachers do
      collection { post :import }
    end
    resources :spheres
    resources :admins
    resources  :admindepartments
    get "overview" => "departments#tree"
    get "overviews" => "courses#tree"
  end
  resources :updateinfors
  resources :teachers, only: [:show, :edit, :update]
end
