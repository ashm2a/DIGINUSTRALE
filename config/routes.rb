Rails.application.routes.draw do
  devise_for :users
  root to: "porcs#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :porcs do
    resources :prisuttus, only: [:new, :create, :edit, :update]
    resources :lonzus, only: [:new, :create, :edit, :update]
    resources :coppas, only: [:new, :create, :edit, :update]
  end

  resources :abattages, only: [:new, :create, :show, :edit, :update]
  # Defines the root path route ("/")
  # root "articles#index"
end
