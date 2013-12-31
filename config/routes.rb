MobileCms::Application.routes.draw do
  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users do
        member do
          get :apps
        end
      end

      resources :apps do
        member do
          get :pages
        end
      end

      resources :pages do
        member do
          get :children
        end
      end
    end
  end

  root to: 'site#index'
  get '(*foo)' => 'site#index'  # capture any route and its params and re-route to site#index
end
