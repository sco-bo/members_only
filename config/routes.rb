Rails.application.routes.draw do
  get 'sessions/new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#delete'

end
