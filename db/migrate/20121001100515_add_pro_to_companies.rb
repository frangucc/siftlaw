class AddProToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :pro, :boolean
  end
end
