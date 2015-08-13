class AddConfirmableToUsers < ActiveRecord::Migration
  def change
    add_column :gesmew_users, :confirmation_token, :string
    add_column :gesmew_users, :confirmed_at, :datetime
    add_column :gesmew_users, :confirmation_sent_at, :datetime
  end
end
