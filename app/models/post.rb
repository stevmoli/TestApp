class Post < ActiveRecord::Base
  attr_accessible :text, :title, :user_id
  belongs_to :user
  validates :user, presence: true
end
