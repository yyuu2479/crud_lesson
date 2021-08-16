Rails.application.routes.draw do
    root  'comments#top'
    resources :comments, only:[:index, :show, :edit, :create, :destroy, :update]
end
