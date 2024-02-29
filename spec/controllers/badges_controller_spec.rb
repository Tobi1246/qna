require 'rails_helper'

RSpec.describe BadgesController, type: :controller do
  describe "GET# Index" do
    let(:user) { create(:user) }
    before { login(user) }
    it 'renders index view' do
      get :index
      expect(response).to render_template :index
    end
  end
end
