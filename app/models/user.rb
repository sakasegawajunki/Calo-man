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

  #before_validation :test

  #def test
  #  byebug
  #end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 画像表示
  attachment :profile_image
  # 会員登録時のバリデーション
  with_options presence: true do
    validates :name
    validates :name_kana
    validates :encrypted_password
    validates :email
    validates :height
    validates :weight
    validates :sex
    validates :age
  end
  enum sex: { "男性": 0, "女性": 1 }

  #カスタマーが退会していなければtrue
  def active_for_authentication?
    super && (self.is_valid == true)
  end

  # インスタンスメソッド
  #BMIの計算を定義する
  def bmi
    (weight*10_000/(height**2).to_f).round(1)
  end


end
