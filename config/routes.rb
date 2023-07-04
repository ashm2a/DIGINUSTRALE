Rails.application.routes.draw do
  devise_for :users
  root to: "porcs#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :porcs, only: [:index, :new, :create, :show, :edit, :update, :gestion] do
    get "gestion", to: "porcs#gestion"
    resources :prisuttus, only: [:new, :create, :edit, :update]
    resources :lonzus, only: [:new, :create, :edit, :update]
    resources :coppas, only: [:new, :create, :edit, :update]
  end

  resources :abattages, except: [:index, :update] do
    get "edit_produits", to: "abattages#edit_produits"
    get "edit_coppa", to: "abattages#edit_coppa"
    get "edit_lonzu", to: "abattages#edit_lonzu"
    get "edit_prisuttu", to: "abattages#edit_prisuttu"
    get "/dashboard", to: "abattages#dashboard"
    get "download", to: "abattages#download"
    get "preview", to: "abattages#preview"
    patch "update_abattage", to: "abattages#update_abattage", as: :update_abattage
    patch "/update_production", to: "abattages#update_production", as: :update_production
    patch "/update_produits", to: "abattages#update_produits", as: :update_produits
    patch "/update_coppa", to: "abattages#update_coppa", as: :update_coppa
    patch "/update_lonzu", to: "abattages#update_lonzu", as: :update_lonzu
    patch "/update_prisuttu", to: "abattages#update_prisuttu", as: :update_prisuttu
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
