require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do

  before do
      @user = FactoryBot.build(:user)
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        @user.name = ''
        expect(@user.save).to be_falsey
      end
    end
    
    context 'name_kanaカラム' do
      it '空欄でないこと' do
        @user.name_kana = ''
        expect(@user.save).to be_falsey
      end
    end
    
    context 'encrypted_passwordカラム' do
      it '空欄でないこと' do
        @user.encrypted_password = ''
        expect(@user.save).to be_falsey
      end
    end
    
    context 'emailカラム' do
      it '空欄でないこと' do
        @user.email = ''
        expect(@user.save).to be_falsey
      end
    end
    
    context 'heightカラム' do
      it '空欄でないこと' do
        @user.height = ''
        expect(@user.save).to be_falsey
      end
    end
    
    context 'weightカラム' do
      it '空欄でないこと' do
        @user.weight = ''
        expect(@user.save).to be_falsey
      end
    end
    
    context 'sexカラム' do
      it '空欄でないこと' do
        @user.sex = ''
        expect(@user.save).to be_falsey
      end
    end
  
    context 'ageカラム' do
     it '空欄でないこと' do
        @user.age = ''
        expect(@user.save).to be_falsey
     end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'CalIngestionモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:cal_ingestions).macro).to eq :has_many
      end
    end
    context 'CalConsumptionモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:cal_consumptions).macro).to eq :has_many
      end
    end
    context 'User_Roomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
    context 'Chatモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:chats).macro).to eq :has_many
      end
    end
    context 'ReverseOfRelationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
    end
    context 'Followerモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
    end
    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end
    context 'Followingモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end
  end
end