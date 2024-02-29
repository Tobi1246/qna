require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:user) { create(:user) }
  describe 'DELETE #destroy' do

    before { login(user) }
    let!(:question) { create(:question, author: user) }
    let!(:link) { create(:link, linkable: question) }

    it 'deletes the question' do
      expect { delete :destroy, params: { id: link }, format: :js }.to change(question.links, :count).by(-1)
    end
  end
end
