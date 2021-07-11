class CalConsumption < ApplicationRecord
  belongs_to :user

    enum action_pattern: { "活発": 0, "仕事": 1, "休日": 2 } #活発:*1.4, 仕事:*1.2, 休日:*1.1　⇒　基礎代謝に対する数値基準

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

  def total_cal_consumptions
    cal_consumption.to_i + base_cal_consumption.to_i
  end

  #1日に保存できるレコードを制限するバリデーション
  validate :cal_consumption_pcount_limit_created_today, if: :new_record?
  MAX_CALCONSUMPTIONS_COUNT =1
  def cal_consumption_pcount_limit_created_today
    return unless CalConsumption.where(user_id: user.id).where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).exists?
    errors.add(:base, "cal_consumptions count limit: #{MAX_CALCONSUMPTIONS_COUNT}")
  end

  #保存した日
  scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }


end