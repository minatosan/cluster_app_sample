Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get 'omniauth' => 'users/registrations#omniauth'
    post 'users/guest_user', to: 'users/sessions#guest_user'
  end
  resources :articles do
    get :search,on: :collection
  end

  resources :main_pages
  resources :top_pages

  resources :profiles do
    get :search, on: :collection
   member do
    get "friend"
    get "article"
    get "group"
    get "comment"
    get "friend_request"
   end
  end

  resources :friends,only:[:create,:destroy,:update]
   
  resources :comments
  resources :groups do
    get :search, on: :collection
    member do
       post "register"
    end
  end

  get 'profile', to: 'profiles#mypage'

  authenticated :user do
    root :to => 'profiles#mypage'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "top_pages#index"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
