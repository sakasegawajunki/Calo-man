class BaseCalConsumption < ApplicationRecord
  
  enum sex: {"男性": 0,"女性": 1}
  enum action_pattern: {"アクティブ": 0,"休日": 1,"仕事": 2}
  
end
