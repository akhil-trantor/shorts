Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'links#new'

  get '/:slug', to: 'links#show'

  resources :links, only: [:create]

end
