Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
    devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
  # 顧客用トップ画面の取得"
  root :to => 'public/homes#top'

  # 顧客用about画面の取得
  get '/about' => "public/homes#about"

  # 顧客用退会確認画面の取得
  get '/customers' => "public/customers#leave"

  get '/orders/:id/thanks' => "public/orders#thanks"

  # 顧客用リソース設定
  scope module: :public do
    resources :customers, only:[:show, :edit, :update]
    patch '/customers/:id/quit' => "customers#quit", as: :quit
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :create, :destroy]
    delete '/cart_items/:id/destroy_all' => "cart_items#destroy_all", as: :destroy_all
    resources :orders, only:[:new, :show, :index]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
  end

  # 管理者用
  # URL /admin/sign_in ...
    devise_for :admin,skip: [:registrations, :passwords], controllers: {
      sessions: "admin/sessions"
    }

  # adminのURLの取得
  get 'admin' => "admin/homes#top"

  # namespace使用
  namespace :admin do
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
  end
end
