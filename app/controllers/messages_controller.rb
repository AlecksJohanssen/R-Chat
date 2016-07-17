  class MessagesController < ApplicationController
    
    before_action :authenticate_user!  
    before_action :get_conversation 
    before_action :secure_conversation 

    def index
      @messages = @conversation.messages.order(created_at: :asc)
      if @messages.length > 10
         @over_ten = true
         @messages = @messages[-10..-1]
      end

      if params[:m]
         @over_ten = false
         @messages = @conversation.messages
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
      params.require(:message).permit(:title, :body, :user_id)
    end

    def get_conversation
      @conversation = Conversation.find(params[:conversation_id])
    end

    def secure_conversation

      current_user_id = current_user.id
      if current_user_id != @conversation.sender_id && current_user_id != @conversation.recipient_id
        redirect_to root_path

      end
    end
end
