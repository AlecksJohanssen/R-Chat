class ConversationsController < ApplicationController
	before_action :authenticate_user!

	def index
	 @users = User.where.not(id: current_user.id)
	 @users = User.all

	 # update dòn này dùm
	 # nay viet cai hàm đó pa, xài đi
	 # e goi cai scope dung k a ? test thử xem
	 # cho coi cái view đi
	 @conversations = Conversation.for(current_user.id)
	 end

	# action nào??????????????????????????? action tao message do ha a 
	# action nào láy message ra màn hình

	def create
	 if Conversation.between(params[:sender_id],params[:recipient_id])
	   .present?
	    @conversation = Conversation.between(params[:sender_id],
	     params[:recipient_id]).first
	 else
	  @conversation = Conversation.create!(conversation_params)
	 end
	 redirect_to conversation_messages_path(@conversation)
	end
	
	private
	 def conversation_params
	  params.permit(:sender_id, :recipient_id)
	 end
end