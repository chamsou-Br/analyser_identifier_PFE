Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/current_customer', to: 'current_customer#index'
  get '/get_current_customer_tags', to: 'current_customer#get_current_customer_tags'

  # resources :tags do
  #   member do
  #     get "confirm_delete"
  #     get "confirm_rename"
  #   end
  # end

  get 'tags/new', to: 'tags#new'
  post 'tags/create', to: 'tags#create'
  post 'tags/delete/:id', to: 'tags#delete', as: :delete_tag
  get 'tags/confirm_delete/:id', to: 'tags#confirm_delete'
  post 'tags/rename/:id', to: 'tags#rename'
  get 'tags/confirm_rename/:id', to: 'tags#confirm_rename'
  get 'tags/:id/test_get_graph', to: 'tags#test_get_graph'

  get 'tags/:id', to: 'tags#show'
  
  get 'tags/hello/:id', to: 'tags#hello'


  resources :tags, only: [] do
    collection do
      get "suggest"
    end
  end

end
