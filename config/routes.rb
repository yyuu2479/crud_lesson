Rails.application.routes.draw do
  resources :comments, only:[:index, :show, :edit, :create, :destroy, :update]
end
