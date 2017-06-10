Rails.application.routes.draw do
  root 'welcome#index'

  get '/variable', to: 'welcome#variable'
  get '/view_content', to: 'welcome#view_content'
  
end
