require 'rails_helper'

RSpec.describe Badge, type: :model do
  it { should have_many(:users).dependent(:destroy) }
end
