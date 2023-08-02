Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'tags/new', to: 'tags#new'
  post 'tags/create', to: 'tags#create'
  post 'tags/delete/:id', to: 'tags#delete', as: :delete_tag
  get 'tags/confirm_delete/:id', to: 'tags#confirm_delete'
  post 'tags/rename/:id', to: 'tags#rename'
  get 'tags/confirm_rename/:id', to: 'tags#confirm_rename'

  get '/tags/:id', to: 'tags#show'
  get '/tags/:id/render_show_html', to: 'tags#render_show_html'

  resources :tags, only: [] do
    collection do
      get "suggest"
    end
  end

end
