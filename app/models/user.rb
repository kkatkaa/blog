class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, foreign_key: :user_id
  has_many :comments
  has_many :likes
  has_many :liked_articles, through: :likes, source: :article

  def admin?
    admin
  end
end
