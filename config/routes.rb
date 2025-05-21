Rails.application.routes.draw do
  resources :todos do
    patch "toggle_complete", on: :member
  end
  root "todos#index"
end
