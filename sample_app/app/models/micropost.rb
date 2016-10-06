class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  default_scope -> { order(created_at: :desc) } 
  mount_uploader :picture, PictureUploader

  # Validates the size of uploaded image
  def picture_size
  	if picture.size > 2.megabytes
  		errors.add(:picture, "should be less than 2 megabytes")
  	end
  end
end
