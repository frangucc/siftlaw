class Company < ActiveRecord::Base
  belongs_to :user
  attr_accessible :about, :address, :budget, :city, :name, :phone, :primary_category, :state, :website
end
