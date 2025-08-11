# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, skip: :all

  namespace :api do
    post 'register', to: 'users#register'
    post 'login', to: 'users#login'
    get 'users/:id', to: 'users#show'
    post 'users', to: 'users#create'
    get 'students', to: 'users#students'

    resources :school_classes, only: %i[index create show update destroy] do
      member do
        post   'add_student/:student_id',    to: 'school_classes#add_student'
        delete 'remove_student/:student_id', to: 'school_classes#remove_student'
      end
    end

    resources :subjects, only: %i[index create destroy]

    get 'school_classes/:school_class_id/subjects', to: 'school_class_subjects#index_for_class'
    get 'subjects/:subject_id/school_classes', to: 'school_class_subjects#index_for_subject'
    post 'school_classes/:school_class_id/subjects/:subject_id', to: 'school_class_subjects#add'
    delete 'school_classes/:school_class_id/subjects/:subject_id',
           to: 'school_class_subjects#remove'
    patch 'school_classes/:school_class_id/subjects/:subject_id/teacher',
          to: 'school_class_subjects#update_teacher'

    resources :school_class_subjects, only: %i[update show destroy] do
      member do
        patch :teacher
      end
    end
  end
end
