Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :quit }
  resources :links, only: %i[destroy]
  resources :badges, only: :index
  resources :questions do
    delete :destroy_attach_file, on: :member
    resources :answers, only: %i[update create destroy mark_best ], shallow: true do
      member do
        patch :mark_best
        delete :destroy_attach_file
      end
    end
  end

  root to: "questions#index"
end
