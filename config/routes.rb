Rails.application.routes.draw do
  root 'home#show'

  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, :skip => [:registrations]                                          
  #   as :user do
  #     get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
  #     put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
  #   end

  resources :thoughts do
    member do
      patch :unpublish
      patch :publish
      patch :trash
      patch :restore
    end
  end
  
end