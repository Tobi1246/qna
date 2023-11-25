class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  
  validates :name, :url, presence: true
  validates :url, format: { with: %r{\Ahttp(s)://.*?/} }, presence: true

end
