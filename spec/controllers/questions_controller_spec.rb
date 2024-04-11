require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author_id: user.id) }
  let(:answer) { create(:answer, question: question, author: user) }

  describe 'GET #index' do 
    it 'renders index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before  { get :show, params: { id: question } }
    it 'renders show view' do 
      expect(response).to render_template :show 
    end
    it 'assigns a new answer for @question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end    
    it 'assigns a new links to @answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end    
  end

  describe 'GET #new' do
    before { login(user) }

    before { get :new }
    it 'renders new view' do  
      expect(response).to render_template :new
    end
    it 'assigns a new question to @question' do 
      expect(assigns(:question)).to be_a_new(Question)
    end
    it 'assigns a new links to @question' do 
      expect(assigns(:question).links.first).to be_a_new(Link)
    end    
  end

  describe 'GET #update' do
    before { login(user) }
    it 'renders update and change attribures' do 
      patch :update, params: { id: question, question: { body: 'new body', title: 'new title' }, format: :js } 
      question.reload
      expect(question.body).to eq 'new body'
      expect(question.title).to eq 'new title'       
      expect(response).to render_template :update
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attribures' do
      it 'saves a new question in the database' do

        expect { post :create, params: { question: attributes_for(:question) } }.to change(user.created_questions, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end
    context 'with invalid attribures' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) }, format: :js }.to_not change(user.created_questions, :count)
      end
      it 're-renders new view' do
        post :new, params: { question: attributes_for(:question, :invalid) }, format: :js
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    context 'with valid attributes' do
      it 'changes question attribures' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload

        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end
      it 'redirects to updated question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change question' do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid), format: :js  }
        question.reload

        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyBody'
      end
      it 're-renders update view' do
        patch :update, params: { id: question, question: attributes_for(:question, :invalid), format: :js  }
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:question) { create(:question, author_id: user.id) }
    it 'deletes the question' do
      expect { delete :destroy, params: { id: question }, format: :js }.to change(user.created_questions, :count).by(-1)
    end
    it 'redirects to index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'DELETE #destroy_vote' do
    before { login(user) }
    let!(:vote) { create(:vote, votable: question, vote_score: 1, user: user) }
    context 'with valid attributes' do
      it 'deletes the question vote' do
        expect { delete :destroy_vote, params: { id: question }, format: :json }.to change(question.votes, :count).by(-1)
      end
    end

    context 'with invalid attributes' do
      let(:user2) { create(:user) }
      before { login(user2) }
      it 'not deletes the question vote' do
        expect { delete :destroy_vote, params: { id: question }, format: :json }.to raise_error(ActionController::RoutingError)
      end
    end   
  end

  describe 'PATCH #good_vote' do
    context 'with valid attributes' do
      before { login(user) }
      it 'create one good vote and double good vote not create' do
        expect { patch :good_vote, params: { id: question, user: user }, format: :json }.to change(question.votes, :count).by(1)
        expect { patch :good_vote, params: { id: question, user: user }, format: :json }.to_not change(question.votes, :count)
      end
    end

    context 'with invalid attributes' do
      it 'good vote do not create' do
        expect { patch :good_vote, params: { id: question }, format: :json }.to_not change(question.votes, :count)
      end
    end
  end

  describe 'PATCH #bad_vote' do
    context 'with valid attributes' do
      before { login(user) }   
      it 'create one bad vote and double bad vote not create' do
        expect { patch :bad_vote, params: { id: question, user: user }, format: :json }.to change(question.votes, :count).by(1)
        expect { patch :bad_vote, params: { id: question, user: user }, format: :json }.to_not change(question.votes, :count)
      end
    end
    context 'with invalid attributes' do
      it 'bad vote do not create' do
        expect { patch :bad_vote, params: { id: question }, format: :json }.to_not change(question.votes, :count)
      end
    end    
  end

  describe 'PATCH #create_coment' do
    context 'with valid attributes' do
      before { login(user) }   
      it 'create coment question' do
        expect { patch :create_coment, params: { id: question, coment: { body: 'body' }}, format: :js }.to change(question.coments, :count).by(1)
      end
    end
    context 'with invalid attributes' do
      it 'bad vote do not create' do
        expect { patch :create_coment, params: { id: question }, format: :js }.to_not change(question.coments, :count)
      end
    end    
  end      
end
