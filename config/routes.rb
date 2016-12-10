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
    resources :edit_topics
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
    resources :files
    resources :timenotifis
    resources :send_emails
    resources :time_protects
    get "overview" => "departments#tree"
    get "overviews" => "courses#tree"
    get "denghi" => "dispatchs#show", format: 'docx'
    get "xinthoi" => "dispatchs#cancel", format: 'docx'
    get "suadoi" => "dispatchs#edit", format: 'docx'
    get "dispatch" => "dispatchs#index"
    get "baove" => "dispatchs#protect", format: 'docx'
    get "baovebyexcel" => "dispatchs#protect_excel", format: 'xlsx'
  end
  resources :edit_topics
  resources :topics
  resources :updateinfors
  resources :teachers, only: [:show, :edit, :update]
  resources :students, only: [:show, :edit, :update]
  resources :department_users, only: [:show, :edit, :update]
  resources :admins, only: [:show, :edit, :update]
  resources :topic_teachers
end
