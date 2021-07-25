require 'rails_helper'

RSpec.describe 'CalConsumptionモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @cal_consumption = FactoryBot.build(:cal_consumption)
    end

    context 'dateカラム' do
      it '空欄でないこと' do
        @cal_consumption.date = ''
        expect(@cal_consumption.save).to be_falsey
      end
      it '同じ登録日は登録できないこと' do
        @cal_consumption.save
        another_cal_consumption = FactoryBot.build(:cal_consumption)
        another_cal_consumption.date = @cal_consumption.date
        another_cal_consumption.valid?
      end
    end

    context 'cal_consumptionカラム' do
      it '数字であること' do
        @cal_consumption.cal_consumption = "aaaaa"
        expect(@cal_consumption.save).to be_falsey
      end
    end

    context "total_cal_consumptionsの数値のテスト" do
      it '合計値が2000' do
        @cal_consumption.base_cal_consumption = 1000
        @cal_consumption.cal_consumption = 1000
        expect(@cal_consumption.total_cal_consumptions).to eq 2000
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(CalConsumption.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
