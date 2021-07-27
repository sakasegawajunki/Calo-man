class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # 100文字以下
  validates :message, length: { maximum: 100 }
  # バリデーション　（空でないことを確認する）
  validates :message, presence: true
  # 作成日時順
  default_scope -> { order(created_at: :desc) }
end
