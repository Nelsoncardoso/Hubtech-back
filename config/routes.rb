Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  # authenticated :user do
    resources :tasks
  # end

end
