PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create] #, :show, :edit, :update]
  end
  resources :categories, only: [:new, :create, :show]
end
