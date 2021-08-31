class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @entry1 = Entry.create(user_id: current_user.id, room_id: @room.id)
    @entry2 = Entry.create(params_user_entry)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entrys = @room.entries
      @another_entry = @entrys.where.not(user_id: current_user.id).first
    end

  end

  private
  def params_user_entry
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end
