Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  namespace :user do
    root to: "dashboard#index", as: :root
  end

  namespace :admin do
    root to: "dashboard#index", as: :root
    resources :test_management, except: [:show] do
      member do
        get :new_question
        post :create_question
        get :edit_question
        patch :update_question
        delete :destroy_question

        get :new_answer
        post :create_answer
        get :edit_answer
        patch :update_answer
        delete :destroy_answer
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
