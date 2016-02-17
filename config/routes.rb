Rails.application.routes.draw do
  root 'posts#index'
  get 'posts/index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#delete'
  resources :posts, only: [:index, :new, :create]
end
