require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'followerモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end

    context 'followedモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
