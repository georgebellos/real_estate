Katikia::Application.routes.draw do

  get '/home' => 'pages#home'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'

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

  root :to => 'pages#home'
end
