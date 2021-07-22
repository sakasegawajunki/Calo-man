require 'rails_helper'

RSpec.describe 'CalIgestionモデルのテスト', type: :model do
  
describe '保存のテスト' do
  let!(:cal_ingestion) { create(:cal_ingestion,breakfast_cal:'hoge',lunch_cal:'lunch_cal',dinner_cal:"dinner_cal",snack_cal:"snack_cal") }
  describe 'トップ画面(root_path)のテスト' do
    before do 
      visit cal_balances_path
    end
  end
end
end