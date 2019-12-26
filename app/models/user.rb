class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
        before_save { self.email = email.downcase }
        # バリデーションに成功し、実際にオブジェクトが保存される直前で実行されます
  attr_accessor :remember_token
  # ログイン時に発行するトークンを保持し、cookieにも同様の値を保持させ、ログインしているかどうかを判別するのに使用します。

  # validates :nickname, presence: true, length: { maximum: 50 }
  # validates :email, presence: true, length: { maximum: 255 },
  #                   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  #                   uniqueness: { case_sensitive: false }
  # validates :profile, length: { maximum: 200}
  # validates :password, presence: true

  has_secure_password
  has_one_attached :avatar

# ログイン周りに必要な定義↓

  # 渡された文字列のハッシュ値を返す。Userモデルのクラスメソッドとして作成する
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す。Userモデルのクラスメソッドとして作成する
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
  #先に属性を定義している
    self.remember_token = User.new_token
    update_attribute(:remember_digest, 
    User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # has_secure_passwordで提供されていたauthenticateメソッドと同じようなものを、独自に定義している。
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
