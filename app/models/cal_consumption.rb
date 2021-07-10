class CalConsumption < ApplicationRecord
  belongs_to :user

    enum action_pattern: { "活発": 0, "普通": 1, "休む": 2 }#活発:*1.4, 普通:*1.2, 休む:*1.1　⇒　基礎代謝に対する数値基準

  def calcurate_base_cal_consumption(user, action_pattern)
    _sex = 0
    if "男性" == user.sex
      value = 1
      if action_pattern == 1
        value = 1
      elsif action_pattern == 2
        value = 0.8
      else
        value = 1.4
      end
      return (13.397*user.weight+4.799*user.height-5.677*user.age+88.362) * value
    else
    _sex = 1
    if "女性" == user.sex
      value = 1
      if action_pattern == 1
        value = 1
      elsif action_pattern == 2
        value = 0.8
      else
        value = 1.4
      end
      return (13.397*user.weight+4.799*user.height-5.677*user.age+88.362) * value
    end
    end
  end

  def total_cal_consumptions
    cal_consumption.to_i + base_cal_consumption.to_i
  end


  # def self.options_select_action_pattern(man_or_woman)
  #   if  man_or_woman == '男性'
  #   action_patterns.select { |pattern| pattern == '' || pattern == '仕事'  }.to_a
  #   else
  #     action_patterns.to_a
  #   end
  # end

end