Katikia::Application.routes.draw do

  get '/home' => 'pages#home'
  get '/info' => 'pages#info'

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :properties do
    collection do
      get :rent
      get :buy

      controller :favorites do
        get 'favorites' => :index
        post 'favorites' => :create
        delete 'favorites' => :destroy
        put 'favorites' => :update
      end

      controller :compares do
        get 'compare' => :index
        post 'compare' => :create
        delete 'compare' => :destroy
        put 'compare' => :update
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :properties do
        collection do
          get :rent
          get :buy
        end
      end
    end
  end

  root :to => 'pages#home'
end
