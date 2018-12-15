class Comment < ApplicationRecord
  validates :commenter, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :body, presence: true, length: {in: 6..500}
  belongs_to :article
end
