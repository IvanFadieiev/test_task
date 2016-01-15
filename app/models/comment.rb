class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  def post
  commentable.is_a?(Post) ? commentable : commentable.post
  end
end
