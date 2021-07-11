class CalIngestion < ApplicationRecord
  belongs_to :user

  def total_cal_ingestions
    breakfast_cal.to_i + lunch_cal.to_i + dinner_cal.to_i + snack_cal.to_i
  end

  #1日に保存できるレコードを制限するバリデーション
  validate :cal_ingestion_count_limit_created_today, if: :new_record?
  MAX_CALINGESTIONS_COUNT = 1
  def cal_ingestion_count_limit_created_today
    return unless CalIngestion.where(user_id: user.id).where(created_at: Time.current.beginning_of_day..Time.current.end_of_day).exists?
   errors.add(:base, "cal_ingestions count limit: #{MAX_CALINGESTIONS_COUNT}")
  end

  #保存した日
  scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
end


