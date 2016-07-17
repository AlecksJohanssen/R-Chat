class UsersController < ApplicationController
	def index

		Rails.logger.info request.env["HTTP_COOKIE"]
		@users = User.all
		@users = User.where.not(id: current_user.id)
		
		# @users = User.where('id != (?)', current_user.id)
	end

	def new
		@user = User.new

	end

	def show
		@friendships = Friendship.all
		@users = User.all

	end

	def sent_message
		@current_user_conversations = Conversation.where('sender_id = ?',current_user.id)
		# @sent_messages = current_user_conversations.first.messages
		@sent_messages = []
		@current_user_conversations.each do |current_user_conversation|
			@test_sent_messages = current_user_conversation.messages.map {|message| message}
			# current_user_conversation.messages.each do |message|
			# 	@sent_messages = @sent_messages.insert(message)
			# end
			@sent_messages.insert(@test_sent_messages)
		end
	end

	def create
		@user = User.new user_params
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path, notice: "Account Created"
		else
			render 'new'
		end
	end 

	private 

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
