Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post 'global', to: 'analyze#global'

  post 'multiple', to: 'analyze#multiple'

  get 'output/*filename', to: 'images#show'

  post "clusters" , to: "clusters#ms_identifiyer"
  

end
