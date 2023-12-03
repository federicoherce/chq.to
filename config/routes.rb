Rails.application.routes.draw do
  resources :posts

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :links, except: [:show]
  get '/l/:short_url', to: 'links#send_to_url'
  post '/l/:short_url', to: 'links#verificar_password'

  root "main#home"
  #root "links#index"
end
