class Comment < ApplicationRecord
	validates :body, presence: true, length: { maximum: 700 }
	validates :post_id, presence: true
	validates :user_id, presence: true
end
