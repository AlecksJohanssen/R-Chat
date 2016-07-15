class Message < ApplicationRecord

	belongs_to :conversation
 	belongs_to :user
 	validates_presence_of :title, :body, :conversation_id, :user_id
 	scope :unread, -> { where(read: false) }
	 def message_time
		created_at.strftime("%m/%d/%y at %l:%M %p")
	 end
	def mark_as_read!
	    self.read = true 
	end

end