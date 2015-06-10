class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body
  validates_presence_of :user, :post
end
