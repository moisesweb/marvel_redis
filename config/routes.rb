Rails.application.routes.draw do
  get 'home/index'
  post 'home/fight'
  post 'home/login'
  root 'home#index'

  ##
  ### begin API routes ->
  ##
  namespace :api, defaults: { format: :json },
   constraints: { subdomain: 'api' }, path: '/' do
    namespace :users do
      #controller :users do
        get :top5
        get :online
        put 'login/:id' => :login, as: :login
      #end
    end
  end

  ##
  ### end API routes
  ##
end
