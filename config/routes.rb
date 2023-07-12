Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"
  get "home/about"=>"public/homes#about",as: 'about'
  
  namespace :public do
    resources :farmers, only: [:index, :show, :edit, :create, :destroy, :update]do
      resource :favorites, only: [:create, :destroy]
      resources :farmer_comments, only: [:create, :destroy]
    end
  
    resources :users, only: [:index, :show, :edit, :update]#do
      #resource :relationships, only: [:create, :destroy]
      #get 'followings' => 'relationships#followings', as: 'followings'
      #get 'followers' => 'relationships#followers', as: 'followers'
  
    resources :groups, except: [:destroy] do
      resource :group_users, only: [:create, :destroy]
    end
    resources :group_users, only: [:edit, :update]
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
