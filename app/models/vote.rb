class Vote < ApplicationRecord
	belongs_to :voteble, polymorphic: true
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => [:voteble_type, :voteble_id] }
end
