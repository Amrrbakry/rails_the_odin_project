class Post < ApplicationRecord
	validates :title, presence: true, length: { maximum: 250 }
	validates :body, presence: true, length: { maximum: 700 }
	validates :user_id, presence: true

	belongs_to :user
	
end
