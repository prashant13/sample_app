class Micropost < ActiveRecord::Base
	attr_accessible :content
	belongs_to :user

	validates :content, :presence => true, :length => { :maximum => 140 }
	validates :user_id, :presence => true

	def self.from_users_followed_by(user)
		where(:user_id => user.following.push(user))		
	end

	scope :from_users_followed_by, lambda { |user| followed_by(user) }

	#default_scope { where :order => 'microposts.created_at DESC' }

	private 

	def self.followed_by(user)
		following_ids = %(SELECT followed_id FROM relationships
						  WHERE follower_id = :user_id)
		where("user_id IN (#{following_ids}) OR user_id = :user_id", 
			  { :user_id => user })
	end
end
