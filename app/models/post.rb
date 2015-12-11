class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 1500 }
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
end
