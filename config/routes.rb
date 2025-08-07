# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, skip: :all

  namespace :api do
    post 'register', to: 'users#register'
    post 'login', to: 'users#login'
    get 'users/:id', to: 'users#show'
    get 'students', to: 'users#students'
    get 'school_classes/:school_class_id/subjects', to: 'school_class_subjects#index_for_class'
    get 'subjects/:subject_id/school_classes', to: 'school_class_subjects#index_for_subject'
    post 'school_classes/:school_class_id/subjects/:subject_id', to: 'school_class_subjects#add'
    delete 'school_classes/:school_class_id/subjects/:subject_id',
           to: 'school_class_subjects#remove'

    namespace :admin do
      resources :users, only: [:create]
      resources :school_classes, only: %i[index create show update destroy] do
        member do
          delete 'remove_student/:student_id', to: 'school_classes#remove_student'
          post 'add_student/:student_id', to: 'school_classes#add_student'
        end
      end
      resources :subjects, only: %i[index create destroy]
    end
  end
end
