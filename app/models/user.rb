class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :lastname_full_width
    validates :firstname_full_width
    validates :lastname_kana
    validates :firstname_kana
    validates :birthday
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  FULL_WIDTH = /\A[ぁ-んァ-ン一-龥々]/.freeze
  KANA = /\A[ァ-ヶー－]+\z/.freeze
  validates_format_of :password, with: PASSWORD_REGEX
  validates_format_of :lastname_full_width, with: FULL_WIDTH
  validates_format_of :firstname_full_width, with: FULL_WIDTH
  validates_format_of :lastname_kana, with: KANA
  validates_format_of :firstname_kana, with: KANA

  has_many :items
end
