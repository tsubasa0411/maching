class User < ApplicationRecord
  attr_accessor :remember_token
  # attr_accessorは、データベースに保存されないカラム(モデルに持たせるデータ)を作る
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :profile, length: { maximum: 200}
  has_secure_password
  # パスワードの検証を行えるようにしている

end
