Rails.application.routes.draw do
  resources :posts

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users/index', to: 'users/registrations#index', as: 'user_index'
  end

  resources :links, except: [:show]

  get 'link_statistics', to: 'link_statistics#index'

  get '/l/:short_url', to: 'links#send_to_url'
  post '/l/:short_url', to: 'links#verificar_password'

  root "main#home"
  #root "links#index"
end
