Rails.application.routes.draw do
  root 'pages#default'
  get '/variable', to: 'pages#variable'
  get '/view_content', to: 'pages#view_content'

  namespace :admin do
    resources :pages
  end
end
