class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :cal_consumptions, dependent: :destroy
  has_many :cal_ingestions, dependent: :destroy
  has_many :user_rooms
  has_many :chats
  # フォロー・フォロワーのアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 画像表示
  attachment :profile_image
  # 会員登録時のバリデーション
  with_options presence: true do
    validates :name
    validates :nama_kana
    validates :password
    validates :email
    validates :height
    validates :weight
    validates :sex
    validates :age
    validates :bmi
  end
end
