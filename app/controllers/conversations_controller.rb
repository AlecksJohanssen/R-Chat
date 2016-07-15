class ConversationsController < ApplicationController

def index
 @users = User.all
 @conversations = Conversation.all
 @messages = Message.all
 end
def new
	@conversations = Conversation.new
end
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
 def set_conversation_params
      @conversation = Conversation.find(params[:id])
    end

end