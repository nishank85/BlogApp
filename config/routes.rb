UserAuth::Application.routes.draw do
  resources :posts do
    member do
      get 'like'
    end
    resources :comments
  end
  match ':controller/:action/:id'
  match ':controller(/:action(/:id))(.:format)'
  root :to => 'posts#index'
  match "signup", :to => "users#new"
  match "login", :to => "sessions#login"
  match "logout", :to => "sessions#logout"
end