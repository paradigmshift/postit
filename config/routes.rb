PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :users do
    resources :posts, shallow: true
  end

  resources :comments
end
