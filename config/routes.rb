Blocipedia::Application.routes.draw do
  devise_for :users
  # resources :charges
  resources :subscriptions
  resources :wikis
  root to: 'welcome#index'
end
