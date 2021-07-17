class CalConsumption < ApplicationRecord
  belongs_to :user

  #バリデーション　（空でないことを確認する）
  validates :date, presence: true
    enum action_pattern: { "活発": 0, "仕事": 1, "休日": 2 } #活発:*1.4, 仕事:*1.2, 休日:*1.1　⇒　基礎代謝に対する数値基準
  # userの性別、年齢、身長、体重、行動パターンからカロリー消費量を計算する式
  def calcurate_base_cal_consumption(user, action_pattern)
    _sex = 0
    if "男性" == user.sex
      value = 1
      if action_pattern == 1
        value = 1.2
      elsif action_pattern == 2
        value = 1.1
      else
        value = 1.4
      end
      return (13.397*user.weight+4.799*user.height-5.677*user.age+88.362) * value
    else
    _sex = 1
    if "女性" == user.sex
      value = 1
      if action_pattern == 1
        value = 1.2
      elsif action_pattern == 2
        value = 1.1
      else
        value = 1.4
      end
      return (9.247*user.weight+3.098*user.height-4.33*user.age+447.593) * value
    end
    end
  end

#カロリー消費量の合計（行動パターンによる基礎代謝 + カロリー消費量）
  def total_cal_consumptions
    cal_consumption.to_i + base_cal_consumption.to_i
  end


  #保存した日
  scope :created_today, -> { where("date >= ?", Time.zone.now.beginning_of_day) }

 #バリデーション（数字のみ + 空の場合を許可する）
   with_options numericality: { only_integer: true }, allow_blank: true do
     validates :cal_consumption
   end

  validates :date, uniqueness: { scope: :user_id }


end