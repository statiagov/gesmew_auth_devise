class AddDeletedAtToUsers < ActiveRecord::Migration
  def change
    add_column :gesmew_users, :deleted_at, :datetime
    add_index :gesmew_users, :deleted_at
  end
end
