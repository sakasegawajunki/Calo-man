require 'rails_helper'

RSpec.describe 'Chatモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @chat = FactoryBot.build(:chat)
    end

    context 'messageカラム' do
      it '100文字以上の場合は登録出来ない' do
        chat = Chat.new(message: "a" * 101)
        expect(chat.invalid?).to be true
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Chat.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Chat.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
