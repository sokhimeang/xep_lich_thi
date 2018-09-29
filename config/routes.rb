Rails.application.routes.draw do
  get "users/new"
  get "users/edit"
  get "users/show"
  get "users/index"
  root "static_pages#home"
  get "static_pages/contact"
  get "static_pages/Home"
  get "static_pages/Contact"
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
  end
  resources :users
end
