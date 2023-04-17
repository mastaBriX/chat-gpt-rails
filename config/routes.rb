Rails.application.routes.draw do
  root 'users#home'

  # chat
  get 'chat', to: 'chat#index'
  post 'chat', to: 'chat#message'
  delete 'chat', to: 'chat#clear_history'


  # 用户登录和登出
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 用户注册路由
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # debug用api
  get 'users/json', to: 'users#json'
  get 'chat/history', to: 'chat#get_history'
end
