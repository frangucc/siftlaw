class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  has_one :company
end
