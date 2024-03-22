require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let!(:answer) { create(:answer, question: question, author: user) }

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attribures' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, author_id: user.id }, format: :js }.to change(question.answers, :count).by(1)
      end
      it 'redirects to create view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, author_id: user.id, format: :js }
        expect(response).to render_template :create
      end
    end
    context 'with invalid attribures' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }, format: :js }.to_not change(question.answers, :count)
      end
      it 're-renders create view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, author_id: user.id, format: :js  }
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
      
      expect(response).to render_template :update        
      end
    end

    context 'with invalid attributes' do
      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
      
        expect(response).to render_template :update 
      end
      it 'form answer not change' do
        expect { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js }.to_not change(answer, :body)
      end
    end
  end

  describe 'DELETE #destroy_vote' do
    before { login(user) }
    let!(:vote) { create(:vote, votable: answer, vote_score: 1, user: user) }
    context 'with valid attributes' do
      it 'deletes the answer vote' do
        expect { delete :destroy_vote, params: { id: answer }, format: :json }.to change(answer.votes, :count).by(-1)
      end
    end

    context 'with invalid attributes' do
      let(:user2) { create(:user) }
      before { login(user2) }
      it 'not deletes the answer vote' do
        expect { delete :destroy_vote, params: { id: answer }, format: :json }.to raise_error(ActionController::RoutingError)
      end
    end   
  end

  describe 'PATCH #good_vote' do
    context 'with valid attributes' do
      before { login(user) }
      it 'create one good vote and double good vote not create' do
        expect { patch :good_vote, params: { id: answer, user: user }, format: :json }.to change(answer.votes, :count).by(1)
        expect { patch :good_vote, params: { id: answer, user: user }, format: :json }.to_not change(answer.votes, :count)
      end
    end

    context 'with invalid attributes' do
      it 'good vote do not create' do
        expect { patch :good_vote, params: { id: answer }, format: :json }.to_not change(answer.votes, :count)
      end
    end
  end

  describe 'PATCH #bad_vote' do
    context 'with valid attributes' do
      before { login(user) }   
      it 'create one bad vote and double bad vote not create' do
        expect { patch :bad_vote, params: { id: answer, user: user }, format: :json }.to change(answer.votes, :count).by(1)
        expect { patch :bad_vote, params: { id: answer, user: user }, format: :json }.to_not change(answer.votes, :count)
      end
    end
    context 'with invalid attributes' do
      it 'bad vote do not create' do
        expect { patch :bad_vote, params: { id: answer }, format: :json }.to_not change(answer.votes, :count)
      end
    end    
  end    

end
