Rails.application.routes.draw do
  devise_for :users
  root "todos#index"
  resources :todos
  put 'todos/:id/complete', :to => "todos#complete", :as => 'complete_todo'
end
