class ChatsController < ApplicationController
  before_action :authenticate_user! # ログイン済ユーザーのみにアクセスを許可する
  def show
    @chatuser = User.find(params[:id]) # チャットするユーザーを取得
    rooms = current_user.user_rooms.pluck(:room_id) # カレントユーザーのuser_roomにあるroom_idの値の配列をroomsに代入
    user_rooms = UserRoom.find_by(user_id: @chatuser.id, room_id: rooms)
    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id) # カレントユーザーのuser_room(共通のroom_idを作る)
      UserRoom.create(user_id: @chatuser.id, room_id: @room.id) # 相手のuser_room(共通のroom_idを作る)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats.page(params[:page]).per(6)
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @room = Room.find_by(id: params[:chat][:room_id].to_i)
    @chats = @room.chats.page(params[:page]).per(6)
    @chat.score = Language.get_data(chat_params[:message])
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
