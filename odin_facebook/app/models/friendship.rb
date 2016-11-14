class Friendship < ApplicationRecord
	belongs_to :user
	belongs_to :friend, class_name: "User"

	validates :user_id, presence: true
	validates :friend_id, presence: true
	validates :status, inclusion: { in: %w(accepted pending requested) },
										 presence: true

	scope :accepted,  -> { where(status: :accepted) }
	scope :pending, 	 -> { where(status: :pending) }
	scope :requested, -> { where(status: :requested) }

end
