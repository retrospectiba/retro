RetroRails::Application.routes.draw do

  get "user/index"

  root :to => "home#index"

  resources :retrospectives
  resources :users do
    resources :retrospectives
  end

  resources :retrospectives do
    resources :goods     , :controller => "retrospectives/goods" do
      collection { get :similar_retro_items }
    end
    resources :bads      , :controller => "retrospectives/bads" do
      collection { get :similar_retro_items }
    end
    resource :invitations, :controller => "retrospectives/invitations"
  end

  get "/retrospectives/:retrospective_id/bads/:id/keep" => "retrospectives/bads#keep", as: :retrospective_bad_keeps
  get "/retrospectives/:retrospective_id/bads/:id/good" => "retrospectives/bads#to_good", as: :retrospective_bad_to_good

  get "/retrospectives/send_email/:id" => "retrospectives#send_email", as: :retrospective_send_email
  get "/retrospectives/preview_email/:id" => "retrospectives#preview_email", as: :retrospective_preview_email

  post   "/votes/:model/:id" => "votes#create", as: :vote_up
  delete "/votes/:model/:id" => "votes#destroy", as: :vote_down

  match "/signup"          => "users#new"
  match "/signin"          => "users#authenticate"
  match "/logout"          => "users#logout"
  match "/password"        => "users#password"
  match "/password_update" => "users#password_update"

  # Error 404 Handler
  match "*path" => "application#not_found"

end
