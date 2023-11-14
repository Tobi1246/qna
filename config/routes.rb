Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :quit }
  resources :questions do
    resources :answers, only: %i[update create destroy mark_best], shallow: true do
      member do
        patch :mark_best
      end
    end
  end

  root to: "questions#index"
end
