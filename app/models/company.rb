class Company < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  attr_accessible :about, :address, :budget, :city, :name, :phone, :primary_category, :pro, :state, :website
  
  def image(type= :thumb)
    portfolio = self.portfolios.first
    portfolio ?  portfolio.image.url(type) : '../assets/side_camera.png'
  end
  
  def is_pro?
    return pro==true
  end
  
  def self.free_listings
    where(pro: nil) | where(pro: false)
  end
  
  def self.pro_listings
    where(pro: true)
  end
  
  def self.recent(x)
    order(:created_at).limit(x).reverse
  end
end
