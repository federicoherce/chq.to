Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :links, only: [:index, :new, :create, :show]
  get '/:short_url', to: 'links#send_to_url'
  root "main#home"
end
