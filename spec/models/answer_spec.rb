require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to :author }
  it { should belong_to :question }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:answers) { create_list(:answer, 2, question: question, author: user) }

  it "should change mark to best" do
    expect { answers[0].mark_best }.to change(answers[0], :best)
  end

  it "should change mark to best and reset other best(only 1 answer to best)" do
    expect { answers[0].mark_best }.to change(answers[0], :best)
    expect { answers[1].mark_best }.to change(answers[1], :best)
    expect { answers[0].reload}.to change(answers[0], :best)
  end

end
