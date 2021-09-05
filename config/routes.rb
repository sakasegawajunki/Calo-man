Rails.application.routes.draw do

  get 'calendars/index'
  root to: "homes#top"
  get "chat/:id" => "chats#show", as: "chat"
  resources :chats, only: [:create]
  resources :users, except:[:destroy] do
    get "users/mydata" => "users#data"
    resource :relationships, only:[:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
    collection do
      get 'unsubcribe' #退会画面
      patch 'withdraw' #is_validを更新する
    end
  end
  resources :data,only:[:index]
  resources :cal_balances, only:[:index]
  resources :cal_ingestions, except:[:destroy, :index, :show]
  resources :cal_consumptions, except:[:destroy, :index, :show]

  devise_for :users,
  path:"",
  path_names: {sign_up:"", sign_in:"login", sign_out:"logout", registration:"sign_up"},
  controllers: {
    sessions:"users/sessions",
    passwords:"users/passwords",
    registrations:"users/registrations"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'#ゲストログイン用
    get 'cal_balances' => 'users/registrations#cal_balance'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
