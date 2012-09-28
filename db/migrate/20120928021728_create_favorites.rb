class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user
      t.belongs_to :company

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :company_id
  end
end
