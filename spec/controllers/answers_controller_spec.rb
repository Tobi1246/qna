require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author_id: user.id) }
  let(:answer) { create(:answers, question_id: :question) }

  describe 'GET #new' do
    before { login(user) }
    it 'renders new view' do
      get :new, params: { question_id: question }

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attribures' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, author_id: user.id } }.to change(question.answers, :count).by(1)
      end
      it 'redirects to show question view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, author_id: user.id }
        expect(response).to redirect_to question_path(question)
      end
    end
    context 'with invalid attribures' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question  } }.to_not change(question.answers, :count)
      end
      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, author_id: user.id  }
        expect(response).to render_template "questions/show"
      end
    end
  end  

end
