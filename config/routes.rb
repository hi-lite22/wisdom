Rails.application.routes.draw do
  resources :answers
  root 'homepage#index'
  get 'questions' => 'questions#index'
 
  resources :questions
  devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
  }
end
