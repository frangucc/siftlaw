class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.belongs_to :user
      t.string :name
      t.string :primary_category
      t.string :budget
      t.text :about
      t.string :city
      t.string :state
      t.string :address
      t.string :website
      t.string :phone

      t.timestamps
    end
    add_index :companies, :user_id
  end
end
