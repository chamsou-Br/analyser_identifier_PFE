Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/current_customer', to: 'current_customer#index'
  get '/get_current_customer_tags', to: 'current_customer#get_current_customer_tags'

  resources :tags do
    member do
      get "confirm_delete"
      get "confirm_rename"
      # post "delete"
      # post "rename"
    end
  end

  post 'tags/delete/:id', to: 'tags#delete', as: :delete_tag
  post 'tags/rename/:id', to: 'tags#rename'
  get 'tags/new', to: 'tags#new'

  resources :tags, only: [] do
    collection do
      get "suggest"
    end
  end

end
