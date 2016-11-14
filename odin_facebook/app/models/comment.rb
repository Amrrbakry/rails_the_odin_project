class Comment < ApplicationRecord
	validates :content, presence: true
	validates :user_id, presence: true
	validates :post_id, presence: true

	default_scope -> { order(created_at: :desc) } 

	belongs_to :user
	belongs_to :post


	has_attached_file 	 :comment_picture, styles: { comment: "400x300>" }
	validates_attachment :comment_picture, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
																 		     file_name: { matches: [/png\z/, /jpe?g\z/, /gif\z/] },
																 				 size: { less_than: 2.megabytes }
end
