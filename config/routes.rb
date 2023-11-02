Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :quit }
  resources :questions do
    resources :answers, only: %i[new create destroy], shallow: true
  end

  root to: "questions#index"
end
