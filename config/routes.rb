Rails.application.routes.draw do
  root 'homepage#index'
  resources :questions
  resources :answers, :except => [:new]
  resources :reactions, :except => [:new]
  get 'questions' => 'questions#index'
  get 'answers/new/:questionId' => 'answers#new'
  get 'reactions/new/:answerId' => 'reactions#new'
 
  devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
  }
end