require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  # let(:user) { create(:user) }
  # byebug
  # let!(:other_user) { create(:user) }
  user = FactoryBot.build(:user)
  # let!(:cal_ingestion) { create(:cal_ingestion, user: user) }
  # let!(:other_cal_ingestion) { create(:cal_ingestion, user: other_user) }

  before do
    user.save!
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '摂取カロリー入力画面のテスト' do
    before do
      visit cal_balances
      click_on "摂取カロリー入力画面へ"
    end

    context "保存成功のテスト" do
    before do
      visit new_cal_ingestion_path
      subject { current_path }
    end
    byebug
        fill_in 'cal_ingestion[breakfast_cal]', with: "1234"
        fill_in 'cal_ingestion[lunch_cal]', with: "1234"
        fill_in 'cal_ingestion[dinner_cal]', with: "1234"
        fill_in 'cal_ingestion[snack_cal]', with: "1234"
        fill_in "cal_ingestion[date]", with: "2020-7-20"
        click_on '保存する'
        is_expected.to have_content 'successfully'

      end
      it '新しい摂取カロリーが正しく保存される' do
        expect { click_button '保存する' }.to change(user.cal_ingestions, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '保存する'
        expect(current_path).to eq '/cal_balances/' + CalIngestion.date
      end

      # it 'Calo-manを押すと、トップ画面に遷移する' do
      #   # home_link = find_all('a')[1].native.inner_text
      #   # home_link = home_link.gsub(/\n/, '').gsub/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link all(:xpath,'//div/a')[0]
      #   is_expected.to eq '/'
      # end
      # it 'Usersを押すと、ユーザ一覧画面に遷移する' do
      #   users_link = find_all('a')[2].native.inner_text
      #   users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link users_link
      #   is_expected.to eq '/users'
      # end
      # it 'Booksを押すと、投稿一覧画面に遷移する' do
      #   books_link = find_all('a')[3].native.inner_text
      #   books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link books_link
      #   is_expected.to eq '/books'
      # end

  end
end