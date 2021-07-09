class BaseCalConsumption < ApplicationRecord
  enum age: {"10歳未満": 0,"10代": 1, "20代": 2, "30代": 3, "40代": 4, "50代": 5, "60歳以上": 6,}
  enum sex: { "男性": 0, "女性": 1 }
  enum action_pattern: { "活発": 0, "普通": 1, "休む": 2 }#活発:*1.4, 普通:*1.2, 休む:*1.1　⇒　基礎代謝に対する数値基準

  # LIST = [
  #   { age: 20, sex: 'man', cal: 1500 },
  #   { age: 20, sex: 'man', cal: 1500 },
  #   { age: 20, sex: 'man', cal: 1500 },
  #   { age: 20, sex: 'man', cal: 1500 },
  #   { age: 0, sex: 'man', cal: 1500 },
  # ]

    LIST = [
    { sex: 0, age: 0, action_pattern: 0, cal_consumption: 1596},#男性・10歳未満
    { sex: 0, age: 0, action_pattern: 1, cal_consumption: 1482},
    { sex: 0, age: 0, action_pattern: 2, cal_consumption: 1254},
    { sex: 0, age: 1, action_pattern: 0, cal_consumption: 2254},#男性・10代
    { sex: 0, age: 1, action_pattern: 1, cal_consumption: 2093},
    { sex: 0, age: 1, action_pattern: 2, cal_consumption: 1771},
    { sex: 0, age: 2, action_pattern: 0, cal_consumption: 2128},#男性・20代
    { sex: 0, age: 2, action_pattern: 1, cal_consumption: 1976},
    { sex: 0, age: 2, action_pattern: 2, cal_consumption: 1672},
    { sex: 0, age: 3, action_pattern: 0, cal_consumption: 2142},#男性・30代
    { sex: 0, age: 3, action_pattern: 1, cal_consumption: 1989},
    { sex: 0, age: 3, action_pattern: 2, cal_consumption: 1683},
    { sex: 0, age: 4, action_pattern: 0, cal_consumption: 2142},#男性・40代
    { sex: 0, age: 4, action_pattern: 1, cal_consumption: 1989},
    { sex: 0, age: 4, action_pattern: 2, cal_consumption: 1683},
    { sex: 0, age: 5, action_pattern: 0, cal_consumption: 1960},#男性・50代
    { sex: 0, age: 5, action_pattern: 1, cal_consumption: 1820},
    { sex: 0, age: 5, action_pattern: 2, cal_consumption: 1540},
    { sex: 0, age: 6, action_pattern: 0, cal_consumption: 1806},#男性・60歳以上
    { sex: 0, age: 6, action_pattern: 1, cal_consumption: 1677},
    { sex: 0, age: 6, action_pattern: 2, cal_consumption: 1419},
    { sex: 1, age: 0, action_pattern: 0, cal_consumption: 1470},#女性・10歳未満
    { sex: 1, age: 0, action_pattern: 1, cal_consumption: 1365},
    { sex: 1, age: 0, action_pattern: 2, cal_consumption: 1155},
    { sex: 1, age: 1, action_pattern: 0, cal_consumption: 1834},#女性・10代
    { sex: 1, age: 1, action_pattern: 1, cal_consumption: 1703},
    { sex: 1, age: 1, action_pattern: 2, cal_consumption: 1441},
    { sex: 1, age: 2, action_pattern: 0, cal_consumption: 1554},#女性・20代
    { sex: 1, age: 2, action_pattern: 1, cal_consumption: 1443},
    { sex: 1, age: 2, action_pattern: 2, cal_consumption: 1221},
    { sex: 1, age: 3, action_pattern: 0, cal_consumption: 1610},#女性・30代
    { sex: 1, age: 3, action_pattern: 1, cal_consumption: 1495},
    { sex: 1, age: 3, action_pattern: 2, cal_consumption: 1265},
    { sex: 1, age: 4, action_pattern: 0, cal_consumption: 1610},#女性・40代
    { sex: 1, age: 4, action_pattern: 1, cal_consumption: 1495},
    { sex: 1, age: 4, action_pattern: 2, cal_consumption: 1265},
    { sex: 1, age: 5, action_pattern: 0, cal_consumption: 1540},#女性・50代
    { sex: 1, age: 5, action_pattern: 1, cal_consumption: 1430},
    { sex: 1, age: 5, action_pattern: 2, cal_consumption: 1210},
    { sex: 1, age: 6, action_pattern: 0, cal_consumption: 1428},#女性・60歳以上
    { sex: 1, age: 6, action_pattern: 1, cal_consumption: 1326},
    { sex: 1, age: 6, action_pattern: 2, cal_consumption: 1122},
  ]

  def self.options_select_sex(man_or_woman)
    sexes.select { |sex| sex == man_or_woman }.to_a
  end

  def self.options_select_action_pattern(man_or_woman)
    if  man_or_woman == '男性'
     action_patterns.select { |pattern| pattern == 'アクティブ' || pattern == '仕事'  }.to_a
    else
      action_patterns.to_a
    end
  end
end
