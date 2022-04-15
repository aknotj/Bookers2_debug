class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message] [:room_id]).present?
      @message = Message.new(message_params.merge(user_id: current_user.id))
      unless @message.save
        @room = Room.find(@message.room_id)
        @messages = @room.messages
        @entries = @room.entries
        render "rooms/show" and return
      end
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id)
  end



end
