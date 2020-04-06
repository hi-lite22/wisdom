Rails.application.routes.draw do
  root 'questions#index'
  resources :questions
  devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
  }
end
