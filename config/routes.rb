Rails.application.routes.draw do
  get 'searches/_search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationship, only: [:create, :destroy]
    member do
      get "following" => "relationships#following", as: "following"
      get "followers" => "relationships#followers", as: "followers"
    end
  end

  get '/search' => "searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end