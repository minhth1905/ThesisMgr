Rails.application.routes.draw do
  get 'static_pages/home'

  root "static_pages#home"
  devise_for :users, controllers: {
    passwords:          "users/passwords",
    sessions: 'users/sessions',
    confirmations:      "users/confirmations",
    registrations: "users/registrations"
  }
end
