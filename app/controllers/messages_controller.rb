class MessagesController < ApplicationController
  before_action do
   @conversation = Conversation.find(params[:conversation_id])
  end

def index
  @conversation = Conversation.find(params[:conversation_id])
 @messages = @conversation.messages
 @messages = Message.order(created_at: :asc)
  if @messages.length > 10
   @over_ten = true
   @messages = @messages[-10..-1]
  end
  if params[:m]
   @over_ten = false
   @messages = @conversation.messages
  end
 if @messages.last
  if @messages.last.user_id = current_user.id
   
  end
 end
@message = @conversation.messages.new
 end




def new
 @message = @conversation.messages.new
end


def create
 @message = @conversation.messages.new (message_params)
  if @message.save
    redirect_to conversation_messages_path(@conversation)
  else
    raise 'Sum tin wong'
 end
end


private
 def message_params
  params.require(:message).permit(:title, :read, :body, :user_id)
 end

end