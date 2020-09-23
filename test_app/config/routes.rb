Rails.application.routes.draw do
  get 'posts/index' => 'posts#index'
  post 'posts/create' => 'posts#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
