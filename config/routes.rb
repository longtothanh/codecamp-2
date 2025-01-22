Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  namespace :user do
    resource :dashboards, only: [ :index ] do
      member do
        get :show, path: 'show/:id'
        post :submit, path: 'submit/:id'
      end
    end
    root to: "dashboards#index", as: :root
  end

  namespace :admin do
    resource :dashboards, only: [ :index ] do
      member do
        get :new_test
        get :show_test, path: 'show_test/:id'
        post :create_test
        get :edit_test
        patch :update_test
        delete :destroy_test, path: 'destroy_test/:id'

        get :new_question
        post :create_question
        get :edit_question, path: 'edit_question/:id'
        patch :update_question
        delete :destroy_question, path: 'destroy_question/:id'

        get :new_answer
        post :create_answer

        get :test_example
      end
    end
    root to: "dashboards#index", as: :root
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
