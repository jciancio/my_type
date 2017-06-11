Rails.application.routes.draw do
  resources :images, only: [:create]

  post '/login' => 'sessions#create'

  resources :users, only: [:index, :show]
  resources :stocks, only: [:index]
  resources :kairos_profile, only: :create
  resources :dislikes, only: :create
  
  post '/pay' => 'credit_cards#create_premium_payment'

  resources :user_likes, path: 'likes', only: [:index, :create, :destroy], shallow: true do
    resources :reaction_data, only: :create
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
