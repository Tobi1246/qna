require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :voteble }
  it { should belong_to :user }

  #it { should validate_uniqueness_of  :user_id, { :scope => [:voteble_type, :voteble_id] } }
end
