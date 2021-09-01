Rails.application.routes.draw do
  get 'messages/create'
  get 'room/create'
  get 'room/show'
    devise_for :users
    
    root  'comments#top'
    resources :comments, only:[:index, :show, :edit, :create, :destroy, :update] do
        resources :post_comments, only:[:create, :destroy]
        resource :favorites, only:[:create, :destroy]
    end

    
    resources :users, only:[:show, :edit, :update] do
        resources :relationships, only:[:create, :destroy]
        get 'following' => 'relationships#following', as: 'following'
        get 'follower' => 'relationships#follower', as: 'follower'
    end
    
    
    resources :rooms, only:[:show, :create]
    resources :messages, only:[:create]
    
    get '/search' => 'searchs#index', as: 'search'
end
