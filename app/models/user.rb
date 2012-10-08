class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  has_one :company, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited?(company)
    return self.favorites.map(&:company).include?(company)
  end
  
  def self.recent(x)
    order(:created_at).limit(x).reverse
  end
  
end
