Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homes#home'
  get 'home/about' => 'homes#about'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  get 'search' => 'books#search'

  resources :books, only: [:create, :show, :index, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
end
