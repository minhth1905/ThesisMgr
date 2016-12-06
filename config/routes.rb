Rails.application.routes.draw do
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  get "home" => "static_pages#index"
  devise_for :users
  resources :teachers, only: [:index,:show]

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
    resources :topic_students do
      collection { post :import }
    end
    resources :timenotifis
    resources :send_emails
    get "overview" => "departments#tree"
    get "overviews" => "courses#tree"
    get "fileword" => "dispatchs#file", format: 'docx'
    get "dispatch" => "dispatchs#index"
  end
  resources :updateinfors
  resources :teachers, only: [:show, :edit, :update]
  resources :students, only: [:show, :edit, :update]
end
