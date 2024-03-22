require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to :author }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }

  it { should accept_nested_attributes_for :links }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }
  let(:good_vote) { question.votes.create(vote_score: 1, user: user) }
  let(:bad_vote) { question.votes.create(vote_score: -1, user: user) }  

  it 'have multi the attach file' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
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
