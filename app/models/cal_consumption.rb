class CalConsumption < ApplicationRecord
  belongs_to :user

  # 活発:x1.4, 仕事:x1.2, 休日:x1.1　⇒　基礎代謝に対する数値基準
  enum action_pattern: { "----  活発  ----": 0, "----  仕事  ----": 1, "----  休日  ----": 2 }
  # userの性別、年齢、身長、体重、行動パターンから基礎代謝量を計算する式

  def calcurate_base_cal_consumption
    # ログに情報出力させる
    logger.info "[calcurate_base_cal_consumption]action_pattern: #{action_pattern}, sex: #{user.sex}, weight: #{user.weight}, height: #{user.height}, age: #{user.age}"
    if "男性" == user.sex
      value = 0.0
      if action_pattern == "----  仕事  ----"
        value = 1.2
      elsif action_pattern ==  "----  休日  ----"
        value = 1.1
      else
        value = 1.4
      end
      return (13.397 * user.weight + 4.799 * user.height - 5.677 * user.age + 88.362) * value
    else
      if "女性" == user.sex
        value = 0.0
        if action_pattern ==  "----  仕事  ----"
          value = 1.2
        elsif action_pattern == "----  休日  ----"
          value = 1.1
        else
          value = 1.4
        end
        return (9.247 * user.weight + 3.098 * user.height - 4.33 * user.age + 447.593) * value
      end
    end
  end

  # カロリー消費量の合計（行動パターンによる基礎代謝 + カロリー消費量）
  def total_cal_consumptions
    cal_consumption.to_i + base_cal_consumption.to_i
  end

  # バリデーション（数字のみ + 空の場合を許可する）
  with_options numericality: { only_integer: true }, presence: true do
    validates :cal_consumption
  end

  # バリデーション　（空でないことを確認する）
  validates :date, presence: true
  # バリデーション　（同じユーザーが特定日に二つデータを作れない）
  validates :date, uniqueness: { scope: :user_id }
end
