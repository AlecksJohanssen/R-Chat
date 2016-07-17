class Conversation < ApplicationRecord
	belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
	belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

	has_many :messages, dependent: :destroy

	validates_uniqueness_of :sender_id, :scope => :recipient_id

	scope :between, -> (sender_id,recipient_id) do
    	where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.recipient_id = ? AND conversations.sender_id = ?)", sender_id,recipient_id, recipient_id, sender_id)
  	end

  	# ủa mà chú, chưa có message sao lại có conversation =)))
  	# nên tạo conversation khi ng ta gửi cái mess đầu tiên
  	# data đang ko consistent rails db:setup lại, và test lại nhé
  	scope :for, -> (user_id) do
  		where("conversations.sender_id = ? OR conversations.recipient_id = ?", user_id, user_id)
  	end
end