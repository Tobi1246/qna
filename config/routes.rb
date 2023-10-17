Rails.application.routes.draw do

  resources :questions do
    resources :answers, only: %i[new create] , shallow: true
  end
end
