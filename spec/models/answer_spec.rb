require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to :author }
  it { should belong_to :question }

  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }

  it { should accept_nested_attributes_for :links }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:answers) { create_list(:answer, 2, question: question, author: user) }
  let(:good_vote) { answers[0].votes.create(vote_score: 1, user: user) }
  let(:bad_vote) { answers[0].votes.create(vote_score: -1, user: user) }

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

  it 'good votes' do
    expect(good_vote.votable.good_votes).to eq(1)
  end

  it 'bad votes' do
    expect(bad_vote.votable.bad_votes).to eq(1)   
  end

  it 'result votes' do
    expect(bad_vote.votable.result_vote).to eq(-1)
  end
end
