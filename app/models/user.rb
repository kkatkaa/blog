class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, foreign_key: :user_id
  has_many :comments
  has_many :likes
  has_many :liked_articles, through: :likes, source: :article
  has_many :comments_raitings

  def rated_for?(comment)
    comments_raitings.where(comment: comment).first
  end

  def admin?
    admin
  end
end
