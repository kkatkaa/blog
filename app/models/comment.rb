class Comment < ApplicationRecord
   include ActiveModel::Validations
  # validates :user, presence: true, email: true
  validates :body, presence: true, length: {in: 6..500}
  belongs_to :article
  belongs_to :user
end
