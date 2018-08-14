Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :enquiries, only: :index do
    collection do
      post :synchronize
    end
  end

  root 'enquiries#index'
end
