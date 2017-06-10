Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users do
    resources :user_likes, path: 'likes', shallow: true do
      resources :reaction_data, shallow: true
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
