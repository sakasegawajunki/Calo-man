require 'rails_helper'

RSpec.describe 'CalIngestionモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @cal_ingestion = FactoryBot.build(:cal_ingestion) # @cal_ingestionを生成する
    end

    context 'dateカラム' do
      it '空欄でないこと' do
        @cal_ingestion.date = ''
        expect(@cal_ingestion.save).to be_falsey
      end
      it '同じ登録日は登録できないこと' do
        @cal_ingestion.save
        another_cal_ingestion = FactoryBot.build(:cal_ingestion)
        another_cal_ingestion.date = @cal_ingestion.date
        another_cal_ingestion.valid?
      end
    end

    context 'breakfast_calカラム' do
      it '数字であること' do
        @cal_ingestion.breakfast_cal = "aaaaa"
        expect(@cal_ingestion.save).to be_falsey
      end
    end

    context 'lunch_calカラム' do
      it '数字であること' do
        @cal_ingestion.lunch_cal = "aaaaa"
        expect(@cal_ingestion.save).to be_falsey
      end
    end

    context 'dinner_calカラム' do
      it '数字であること' do
        @cal_ingestion.dinner_cal = "aaaaa"
        expect(@cal_ingestion.save).to be_falsey
      end
    end

    context 'snack_calカラム' do
      it '数字であること' do
        @cal_ingestion.snack_cal = "aaaaa"
        expect(@cal_ingestion.save).to be_falsey
      end
    end

    context "total_cal_ingestionsの数値のテスト" do
      it '合計値が400' do
        @cal_ingestion.breakfast_cal = 100
        @cal_ingestion.lunch_cal = 100
        @cal_ingestion.dinner_cal = 100
        @cal_ingestion.snack_cal = 100
        expect(@cal_ingestion.total_cal_ingestions).to eq 400
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(CalIngestion.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
