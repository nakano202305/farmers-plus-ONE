Rails.application.routes.draw do

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  scope module: :public do

    root to: "homes#top"
    get "about"=>"homes#about"


    resources :farmers, only: [:index, :show, :edit, :create, :destroy, :update]do
      resource :favorites, only: [:create, :destroy]
      resources :farmer_comments, only: [:create, :destroy]
    end

    resources :users, only: [:index, :show, :edit, :update]#do
      #resource :relationships, only: [:create, :destroy]
      #get 'followings' => 'relationships#followings', as: 'followings'
      #get 'followers' => 'relationships#followers', as: 'followers'

    resources :groups, only:  [:new, :index, :show, :create, :edit, :update] do
      resource :group_users, only: [:create, :destroy]
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"
    end
    resources :group_users, only: [:edit, :update]
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do

    get '/'=>'homes#top'
  
    resources :users, only: [:show, :destroy]
    resources :farmers, only: [:index, :show, :destroy]
    resources :groups, only: [:index, :destroy]
  
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
