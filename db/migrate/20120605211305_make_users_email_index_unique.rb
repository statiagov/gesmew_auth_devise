class MakeUsersEmailIndexUnique < ActiveRecord::Migration
  def up
    add_index "gesmew_users", ["email"], :name => "email_idx_unique", :unique => true
  end

  def down
    remove_index "gesmew_users", :name => "email_idx_unique"
  end
end
