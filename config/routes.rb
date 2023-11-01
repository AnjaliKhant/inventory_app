Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stores, only: [:index]

  resources :inventory do
    collection do
      get 'stores_with_sales'
      get 'popular_shoe'
    end
  end
end
