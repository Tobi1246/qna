require 'rails_helper'

RSpec.describe ComentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, author_id: user.id) }
  let!(:answer) { create(:answer, question: question, author: user) }

  describe 'DELETE #destroy' do
    before { login(user) }
    context 'with valid attributes question coment' do
      let!(:coment) { create(:coment, comentable: question, body: 1, user: user) }
      it 'deletes the question coment' do
        expect { delete :destroy, params: { id: coment }, format: :js}.to change(question.coments, :count).by(-1)
      end
    end
    context 'with valid attributes answer coment' do
      let!(:coment) { create(:coment, comentable: answer, body: 1, user: user) }
      it 'deletes the answer coment' do
        expect { delete :destroy, params: { id: coment }, format: :js}.to change(answer.coments, :count).by(-1)
      end
    end
    context 'with invalid attributes answer coment' do
      let!(:coment) { create(:coment, comentable: answer, body: 1, user: user) }
      it 'deletes the answer coment' do
        expect { delete :destroy, params: { id: nil }, format: :js}.to raise_error
      end
    end             
  end
end
