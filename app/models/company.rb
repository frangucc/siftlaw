class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  attr_accessible :about, :address, :budget, :city, :name, :phone, :primary_category, :state, :website
end
