class Comment < ApplicationRecord
   include ActiveModel::Validations
  # validates :user, presence: true, email: true
  validates :body, presence: true, length: {in: 6..500}
  belongs_to :article, counter_cache: true
  belongs_to :user
  has_many :comments_raitings
end
