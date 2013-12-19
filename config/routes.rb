Blocipedia::Application.routes.draw do
  devise_for :users
  resources :charges

  root to: 'welcome#index'
end
