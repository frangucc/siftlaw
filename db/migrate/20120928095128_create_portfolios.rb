class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.belongs_to :company
      t.attachment :image

      t.timestamps
    end
    add_index :portfolios, :company_id
  end
end
