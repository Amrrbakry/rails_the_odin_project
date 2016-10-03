class Post < ApplicationRecord
	validates :title, presence: true, length: { maximum: 70 }
	validates :body, presence: true, length: { maximum: 3000 }

	belongs_to :user

end
