Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
      :sessions => "users/sessions",
      :registrations => "users/registrations" }
  root to: "public#index"

  match 'admin/academic' => 'admin#academic', :via => :get
  match 'admin/pdf' => 'admin#pdf', :via => :get

  resources :users do
    member do
      get :delete
    end
  end

  resources :fixed_duration_programs do
    member do
      get :delete
    end
  end

  resources :insurances do
    member do
      get :update_insurance_cost
    end
  end

  resources :notes do
    member do
      get :delete
    end
  end

  resources :statements do
    member do
      get :delete
    end
  end

  resources :digital_tests do
    member do
      get :delete
    end
  end

  resources :admin do
    collection do
      get :academic
    end
    member do
      get :delete
    end
  end

  resources :payments do
    member do
      get :delete
    end
  end

  resources :invoices do
    member do
      get :load_config
      get :delete
    end
  end

  resources :agencies do
    member do
      get :delete
    end
  end

  resources :promos do
    member do
      get :delete
    end
  end

  resources :regions do

    member do
      get :delete
    end
  end

  resources :accommodations do
    member do
      get :delete
    end
  end

  resources :hours do
    member do
      get :delete
    end
  end
  
  resources :special_activities do
    member do
      get :delete
    end
  end
  
  resources :programs do
    member do
      get :delete
    end
  end
  
  resources :tests do
    member do
      get :delete
    end
  end
  
  resources :quizzes do
    member do
      get :delete
    end
  end
  
  resources :students do
    collection do
      post :import
      get :edit_multiple
      get :active
      get :student_list
      put :update_multiple
      patch :activate
      patch :deactivate
    end

    member do
      get :delete
    end

    resources :study_periods do
      member do
        get :letter_of_acceptance
        get :delete
      end
    end

    resources :quotes do
      member do
        get :load_config
        get :delete
      end
    end

    resources :pro_formas do
      member do
        get :load_config
        get :delete
      end
    end

    resources :invoices do
      member do
        get :delete
      end
    end
  end
  
  resources :attendances do
    member do
      get :delete
      patch :justify_absence
    end
  end
  
  resources :targets do
    member do
      get :delete
    end
  end
  
  resources :evaluations do
    member do
      get :report
      get :delete
      get :exercises
      get :daily
      get :regular
      put :set_evaluation_to_active
    end
  end

  resources :sharp_and_smarts do
    member do
      get :delete
    end
  end

  resources :automatizations do
    member do
      get :delete
    end
  end
  
  resources :items do
    member do
      get :delete
    end
  end

  
  resources :quotes, only: [:index]
  
  resources :pro_formas, only: [:index]
  
  resources :invoices, only: :index

  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  match "/course/" => "public#language", via: :get, :as => :course_language

  match "/course/:language" => "public#group", via: :get, :as => :course_language_group

  match "/course/:language/group/:group" => "public#type", via: :get, :as => :course_language_group_type

  match "/course/:language/group/:group/type/attendances/" => "attendances#batch_edit", via: :get, :as => :course_language_group_type_attendances

  match "/course/:language/group/:group/type/targets/" => "targets#batch_edit", via: :get, :as => :course_language_group_type_targets

  match "/course/:language/group/:group/type/sharp_and_smarts/" => "sharp_and_smarts#batch_edit", via: :get, :as => :course_language_group_type_sharp_and_smarts

  match "/course/:language/group/:group/type/automatizations/" => "automatizations#batch_edit", via: :get, :as => :course_language_group_type_automatizations

end
