Rails.application.routes.draw do
  post '/login' => 'sessions#create'

  resources :users, only: :index do
    resources :kairos_profile, only: :create
    resources :user_likes, path: 'likes', shallow: true do
      resources :reaction_data, shallow: true
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
