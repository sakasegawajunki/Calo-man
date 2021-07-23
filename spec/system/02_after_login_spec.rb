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

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'Calo-manを押すと、トップ画面に遷移する' do
        # home_link = find_all('a')[1].native.inner_text
        # home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        byebug
        click_link all(:xpath,'//div/a')[0]
        is_expected.to eq '/'
      end
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
end