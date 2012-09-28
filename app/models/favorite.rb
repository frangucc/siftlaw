class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  attr_accessible :company_id
  validates :company_id, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true
end
