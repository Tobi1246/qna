require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answers, question_id: :question) }

  describe 'GET #new' do
    it 'renders new view' do
      get :new, params: { question_id: question }

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attribures' do
      it 'saves a new answer in the database' do

        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)
      end
      it 'redirects to show question view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question  }
        expect(response).to redirect_to questions_path
      end
    end
    context 'with invalid attribures' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question  } }.to_not change(Answer, :count)
      end
      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question  }
        expect(response).to render_template :new
      end
    end
  end  

end
