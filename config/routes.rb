Blocipedia::Application.routes.draw do
  devise_for :users
  # resources :charges
  resources :subscriptions

  root to: 'welcome#index'
end
