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
    get 'search' => 'searches#search'

    resources :farmers, only: [:index, :show, :edit, :create, :destroy, :update]do
      collection do
        get :favorite_farmers
      end
      resource :favorites, only: [:create, :destroy]
      resources :farmer_comments, only: [:create, :destroy]
    end

    resources :users, only: [:index, :show, :edit, :update, :create, :destroy]

    resources :groups do
      resource :group_users, only: [:create, :destroy]
      get "new/mail" => "groups#new_mail"
      get "send/mail" => "groups#send_mail"
    end
    resources :group_users, only: [:edit, :update]
  end

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do

    get '/'=>'homes#top'

    resources :users, only: [:destroy]
    resources :farmers, only: [:index, :show, :destroy]do
      resources :farmer_comments, only: [:destroy]
    end
    resources :groups, only: [:index, :destroy]


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
