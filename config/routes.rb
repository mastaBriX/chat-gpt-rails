Rails.application.routes.draw do

  root 'users#home'
  get 'ping', to:'health_check#ping'

  # chat
  get 'chat', to: 'chat#index'
  post 'chat', to: 'chat#message'
  delete 'chat', to: 'chat#clear'

  # 用户登录和登出
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 用户注册路由
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'


  # Admin
  get 'admin', to: 'admin#index'
  delete 'admin/delete', to: 'admin#destroy'

  # debug用api
  get 'users/json', to: 'users#json'
  get 'chat/history', to: 'chat#get_history'


end
