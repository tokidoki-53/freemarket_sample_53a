Rails.application.routes.draw do

  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :items, only: [:index, :show, :destroy] do
    get 'myitem'
    patch 'suspend_showing_item'
    patch 'resume_showing_item'
    patch 'notify_send_item'
  end

  resource :mypages, only: [:index] do
    get 'index'
    member do
      get 'profile'
      get 'deliver_address'
      get 'credit'
      get 'email_password'
      get 'identification'
      get 'sms_confirmation'
      get 'purchase'
      get 'purchased'
      patch 'update_user'
      patch 'update_address'
    end
    resources :listings do
      collection do
        get 'listing'     #出品中
        get 'in_progress' #取引中
        get 'completed'   #売却済み
      end
    end
  end

  resources :logout, only: :index

  resources :sell, only: [:index, :create, :edit, :update] do
    collection do
        get 'get_category_children', defaults: {format: 'json'}
        get 'get_delivery_types', defaults: {format: 'json'}
        put 'completed' # 取引中の商品を発送
    end
  end

  resources :buy do
    collection do
      get 'show', to: 'buy#show'
      post 'purchase', to: 'buy#purchase'
    end
    member do
      put 'purchase'  # 商品の購入を確定
    end
  end

  resources :credit, only: [:create] do
    collection do
      post 'delete', to: 'credit#delete'
      get 'edit'
    end
    member do
      get 'confirmation'
    end
  end

  resources :signup do          #新規登録用コントローラー
    collection do
      get 'registration_type'   #新規登録を、メールor Facebook or google選択画面
      get 'registration'        #会員情報登録画面
      get 'sms_confirmation'    #TEL登録画面（SMS認証）
      get 'address'              #住所情報登録画面
      # get 'credit'              #クレジット情報登録画面
      get 'complete'            #完了画面
    end
  end
  root 'items#index'
end
