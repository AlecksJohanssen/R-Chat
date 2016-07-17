  class MessagesController < ApplicationController
    # viết như vậy thì conversation 1 giữa A và B
    # một ng C gõ vào localhost:3000/converstaions/1 cũng sẽ xem dc conversation giữa
    # A và B rùi?
    # da vang a dung r =( e chua biet fix)

    before_action :authenticate_user! # chưa logic thì kick nó ra 
    before_action :get_conversation # sẽ gọi hàm này trước mọi action

    # đồng thời sau đó gọi hàm này, éo phải conversation thì kich nó ra
    # tý nhơ xóa mấy dòng comment này dùm =)))
    before_action :secure_conversation 

    def index
      @messages = @conversation.messages.order(created_at: :asc)
      # cai code hoi nay cua e la` no lay het tat ca cac message luon pk a =()
      # yes it is man fuck this crap =()
      # test đi =)) dung r a :))) oh my lord
      # test lại đi
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
      # cho coi terminal
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
      # Qua messgener
      current_user_id = current_user.id
      if current_user_id != @conversation.sender_id && current_user_id != @conversation.recipient_id
        redirect_to root_path

      end
    end
end
