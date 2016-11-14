class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  validates :username, presence: true, uniqueness: true, length: { maximum: 55 }
  validates :email, presence: true, uniqueness: true

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :friendships
  has_many :friends,  -> { Friendship.accepted }, through: :friendships
  

  has_many :inverse_friendships, class_name: "Friendship",
                                 foreign_key: "friend_id"
  has_many :inverse_friends, -> { Friendship.accepted },
                             through: :inverse_friendships, 
                             source: :user


  has_many :pending_requests, -> { Friendship.pending },
                              class_name: "Friendship"
  
  has_many :friend_requests,  -> { Friendship.requested },  
                              class_name: "Friendship"

	# checks if the user already likes a post
	def already_likes?(post)
  	!self.likes.find_by('post_id = ?', post.id).nil?
	end

  # becomes a friend with another user
  def friend(other_user)
    friend_requests.create(friend_id: other_user.id) if !friend_requested?(other_user)
    other_user.pending_requests.create(friend_id: self.id) 
  end

  # unfriends a user
  def unfriend(other_user)
    if self.friends?(other_user)
      friendships.find_by(friend_id: other_user.id).destroy
      other_user.friendships.find_by(friend_id: self.id).destroy
    elsif other_user.inverse_friends?(self)
      inverse_friendships.find_by(user_id: other_user.id).destroy
      other_user.inverse_friendships.find_by(user_id: self.id).destroy
    else
      pending_requests.find_by(friend_id: other_user.id).destroy
      other_user.friend_requests.find_by(friend_id: self.id).destroy
    end
  end

  # returns true if the current user is friends with the other user
  def friends?(other_user)
    self.friendships.where(status: "accepted", friend_id: other_user.id).exists?
  end

  # returns true if the other user if friends with current user
  def inverse_friends?(other_user)
    other_user.inverse_friendships.where(status: "accepted", friend_id: self.id).exists?
  end

  # checks if a friend request has already been sent
  def friend_requested?(other_user)
    friend_request = self.friendships.where(friend_id: other_user.id, status: "requested")
    !friend_request.empty?
  end

  # checks if the user has a pending request from other user
  def has_pending_request_from?(other_user)
    !pending_requests.where(friend_id: other_user.id).empty?
  end

  # Returns a user's status feed.
  def feed
    friends_ids = "SELECT   friend_id FROM friendships
                     WHERE  user_id = :user_id AND status = 'accepted'" 
    Post.where("user_id IN (#{friends_ids})
                     OR user_id = :user_id", user_id: self.id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name  
      UserMailer.welcome(user).deliver if user.valid? 
    end
  end 

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.username = data["name"] if user.username.blank?
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
