Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :quit }
  resources :links, only: %i[destroy]
  
  concern :voteble do
    member do 
      patch :bad_vote
      patch :good_vote                       
      delete :destroy_vote
    end
  end 

  resources :badges, only: :index
  resources :questions, concerns: [:voteble] do
    delete :destroy_attach_file, on: :member
    resources :answers, concerns: [:voteble], only: %i[update create destroy mark_best destroy_vote 
                                        good_vote bad_vote], shallow: true do
      member do
        patch :mark_best
        delete :destroy_attach_file
      end
    end
  end

  root to: "questions#index"
end
