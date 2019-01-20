class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum: 5}

  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes
  belongs_to :user

  scope :published, -> {where(published: true)}

  def tags=(value)
    value = sanitize_tags(value) if value.is_a?(String)

    super(value)
  end

  def css_class
    if published?
      'normal'
    else
      'unpublished'
    end
  end

  private

  def sanitize_tags(text)
    text.downcase.split.uniq
  end
end
