Rails.application.routes.draw do
  get 'rooms/new'
  get 'rooms/edit'
  get 'rooms/index'
  get 'rooms/show'
  resources :rooms

  get "login", to: "login#new"
  post "login", to: "login#create"
  delete "logout", to: "login#destroy"

  get "user_subjects/new"
  resources :user_subjects

  get "subjects/new"
  get "subjects/edit"
  get "subjects/show"
  get "subjects/index"
  resources :subjects

  get "users/new"
  get "users/edit"
  get "users/show"
  get "users/index"
  get "register_subject", to: "users#register_subjects"
  post "register_subject", to: "users#do_register_subjects"
  root "static_pages#home"
  get "contact", to: "static_pages#contact"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
  end
  resources :users do
    collection do
      get :register_subjects, as: :register_subjects
    end
  end
  resources :users
end
