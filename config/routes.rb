 Rails.application.routes.draw do  
  devise_for :users, controllers: { confirmations: 'users/confirmations' }

  root 'users#index'    
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end
end

# # Rails.application.routes.draw do
# #   devise_for :users, controllers: { confirmations: 'users/confirmations' }

# #   root 'devise/sessions#new'  # Set the root to the Devise sign-in page

# #   resources :users, only: [:index, :show] do
# #     resources :posts, only: [:index, :show, :new, :create] do
# #       resources :comments, only: [:create]
# #       resources :likes, only: [:create]
# #     end
# #   end
# # end

# Rails.application.routes.draw do
#   devise_for :users, controllers: { confirmations: 'users/confirmations' }

#   # Define the root path explicitly, specifying the Devise mapping
#   authenticated :user do
#     root 'users#index', as: :authenticated_root
#   end

#   unauthenticated do
#     root 'devise/sessions#new', as: :unauthenticated_root
#   end

#   resources :users, only: [:index, :show] do
#     resources :posts, only: [:index, :show, :new, :create] do
#       resources :comments, only: [:create]
#       resources :likes, only: [:create]
#     end
#   end
# end
