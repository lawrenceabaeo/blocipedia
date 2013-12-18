Blocipedia::Application.routes.draw do
  resources :charges

  root to: 'welcome#index'
end
