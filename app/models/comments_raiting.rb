class CommentsRaiting < ApplicationRecord
  validates :user, uniqueness: {scope: :comment, message: 'already rated'}

  belongs_to :comment
  belongs_to :user

end
