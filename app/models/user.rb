class User < ApplicationRecord
	has_secure_password
	has_many :friendships
	has_many :messages
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	
	def received_messages
    	where(recipient: self)
  	end

  	def last_online
  		self.created_at = Time.now
  	end

	def is_friend?(user)
		self.friend_ids.include?(user.id)
	end

	def sent_messages

	end
end
