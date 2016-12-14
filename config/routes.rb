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
    resources :books
    resources :reviews do
      collection { post :import }
    end
    resources :reports
    resources :councils
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
    get "baove" => "dispatchs#protect_word", format: 'docx'
    get "baovebyexcel" => "dispatchs#protect_excel", format: 'xlsx'
    get "protect" => "dispatchs#protect"
    get "hoidong" => "dispatchs#councils", format: 'docx'
    get "hoidongbaove" => "dispatchs#indexcouncil"
    get "reportfile" => "reports#report"
    get "reportword/:id" => "reports#onereport", format: 'docx'
    get "example" => "reviews#example", format: 'xlsx'
    get "reported" => "dispatchs#reported",format: 'docx'
    get "indexreported" => "dispatchs#indexreported"
  end
  resources :edit_topics
  resources :alltopics
  resources :topics
  resources :updateinfors
  resources :teachers, only: [:show, :edit, :update]
  resources :students, only: [:show, :edit, :update]
  resources :department_users, only: [:show, :edit, :update]
  resources :admins, only: [:show, :edit, :update]
  resources :topic_teachers
  get "teachers/info/:id" => "alltopics#show"
  get "overview" => "admin/departments#tree"
  get "spheres" => "admin/spheres#index"

  post "info" => "ajax#update_info_status"
  get "get-info" => "ajax#get_info"
end
