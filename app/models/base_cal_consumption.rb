class BaseCalConsumption < ApplicationRecord
  enum sex: { "男性": 0, "女性": 1 }
  enum action_pattern: { "アクティブ": 0, "休日": 1, "仕事": 2 }
  
  LIST = [
    { age: 20, sex: 'man', cal: 1500 },
    { age: 20, sex: 'man', cal: 1500 },
    { age: 20, sex: 'man', cal: 1500 },
    { age: 20, sex: 'man', cal: 1500 },
    { age: 0, sex: 'man', cal: 1500 },
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
