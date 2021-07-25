require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '摂取カロリー入力画面のテスト' do
    context "保存成功のテスト" do
      it '新しい摂取カロリーが正しく保存される' do
        visit cal_balances_path
        click_on "摂取カロリー入力画面へ"
        visit new_cal_ingestion_path
        subject { current_path }
        fill_in 'cal_ingestion[breakfast_cal]', with: "1234"
        fill_in 'cal_ingestion[lunch_cal]', with: "1234"
        fill_in 'cal_ingestion[dinner_cal]', with: "1234"
        fill_in 'cal_ingestion[snack_cal]', with: "1234"
        page.execute_script("$('#cal_ingestion_date').val('2021-07-17')")
        click_on '保存する'

        is_expected.to have_content '保存成功のテスト'
        expect(CalIngestion.last.breakfast_cal).to eq 1234
        expect(CalIngestion.last.lunch_cal).to eq 1234
        expect(CalIngestion.last.dinner_cal).to eq 1234
        expect(CalIngestion.last.snack_cal).to eq 1234
        expect(has_current_path?('/cal_balances?created_date=2021-07-17')).to be_truthy
      end
      it '新しい摂取カロリーが正しく更新される' do
        cal_ingestion = CalIngestion.create(date: '2021-07-17', user_id: user.id)
        visit edit_cal_ingestion_path(cal_ingestion.id)
        subject { current_path }
        fill_in 'cal_ingestion[breakfast_cal]', with: "2345"
        fill_in 'cal_ingestion[lunch_cal]', with: "2345"
        fill_in 'cal_ingestion[dinner_cal]', with: "2345"
        fill_in 'cal_ingestion[snack_cal]', with: "2345"
        page.execute_script("$('#cal_ingestion_date').val('2021-07-17')")
        click_on '更新する'
      end
    end
  end
    
  describe '消費カロリー入力画面のテスト' do
    context "保存成功のテスト" do
      it '新しい消費カロリーが正しく保存される' do
        visit cal_balances_path
        click_on "消費カロリー入力画面へ"
        visit new_cal_consumption_path
        subject { current_path }
          fill_in 'cal_consumption[cal_consumption]', with: "1234"
        byebug
          select(value = "0", from: 'cal_consumption[action_pattern]')
          page.execute_script("$('#cal_consumption_date').val('2021-07-17')")
          click_on '保存する'
          is_expected.to have_content '保存成功のテスト'
          expect(CalConsumption.last.cal_consumption).to eq 1234
          expect(CalConsumption.last.action_pattern).to eq 0
          expect(CalConsumption.last.base_cal_consumption).to eq (13.397*user.weight+4.799*user.height-5.677*user.age+88.362) * 1.4
          expect(has_current_path?('/cal_balances?created_date=2021-07-17')).to be_truthy
      end
    end
  end
end