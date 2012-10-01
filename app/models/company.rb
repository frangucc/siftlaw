class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  attr_accessible :about, :address, :budget, :city, :name, :phone, :primary_category, :state, :website
  
  def image(type= :thumb)
    portfolio = self.portfolios.first
    portfolio ?  portfolio.image.url(type) : '../assets/side_camera.png'
  end
  
  def self.recent(x)
    order(:created_at).limit(x).reverse
  end
end
