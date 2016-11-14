class Post < ApplicationRecord
	validates :content, presence: true
	validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) } 

	belongs_to :user
	has_many :comments, 	 dependent: :destroy
	has_many :likes,    	 dependent: :destroy

	has_attached_file :picture, styles: { timeline: "400x200>", post: "600x400>" }
	validates_attachment :picture, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
																 file_name: { matches: [/png\z/, /jpe?g\z/, /gif\z/] },
																 size: { less_than: 2.megabytes }
end
