MobileCms::Application.routes.draw do
  devise_for :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'site#index'
  get '(*foo)' => 'site#index'  # capture any route and its params and re-route to site#index
end
