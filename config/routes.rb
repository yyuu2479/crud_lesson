Rails.application.routes.draw do
    devise_for :users
    
    root  'comments#top'
    resources :comments, only:[:index, :show, :edit, :create, :destroy, :update]
    resources :users, only:[:show, :edit, :update]
end
