class CalIngestion < ApplicationRecord
  belongs_to :user

  # カロリー摂取量の合計（朝食+昼食+夕食+間食）
  def total_cal_ingestions
    breakfast_cal.to_i + lunch_cal.to_i + dinner_cal.to_i + snack_cal.to_i
  end

  # バリデーション（数字のみ + 空の場合を許可する）
  with_options numericality: { only_integer: true }, presence: true do
    validates :breakfast_cal
    validates :lunch_cal
    validates :dinner_cal
    validates :snack_cal
  end
  # バリデーション　（空でないことを確認する）
  validates :date, presence: true
  # 同じユーザーは特定日に一つしかデータを作ることが出来ない
  validates :date, uniqueness: { scope: :user_id }
end
