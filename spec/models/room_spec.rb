require 'rails_helper'

RSpec.describe 'Roomモデルのテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'user_roomモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
     context 'chatモデルとの関係' do
      it '1:Nとなっている' do
        expect(Room.reflect_on_association(:chats).macro).to eq :has_many
      end
     end
   end
end