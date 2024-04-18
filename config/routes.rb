Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :quit }
  resources :links, only: %i[destroy]
  resources :coments, only: %i[destroy]

  concern :votable do
    member do 
      patch :bad_vote
      patch :good_vote                       
      delete :destroy_vote
    end
  end

  concern :comentable do
    member do 
      patch :create_coment
    end
  end    

  resources :badges, only: :index
  resources :questions, concerns: %i[votable comentable] do
    delete :destroy_attach_file, on: :member
    resources :answers, concerns: %i[votable comentable], only: %i[update create destroy mark_best], shallow: true do
      member do
        patch :mark_best
        delete :destroy_attach_file
      end
    end
  end

  root to: "questions#index"

  mount ActionCable.server => '/cable'
end
