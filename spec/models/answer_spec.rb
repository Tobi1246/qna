require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to :author }
  it { should belong_to :question }

  it { should have_many(:links).dependent(:destroy) }

  it { should accept_nested_attributes_for :links }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:answers) { create_list(:answer, 2, question: question, author: user) }

  it "should change mark to best" do
    expect { answers[0].mark_best }.to change(answers[0], :best)
  end

  it "should change mark to best and reset other best(only 1 answer to best)" do
    expect { answers[0].mark_best }.to change(answers[0], :best)
    expect { answers[1].mark_best }.to change(answers[1], :best)
    expect { answers[0].reload }.to change(answers[0], :best)
  end

  it 'have multi the attach file' do
    expect(question.answers.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end  
end
