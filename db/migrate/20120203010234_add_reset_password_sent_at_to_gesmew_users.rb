class AddResetPasswordSentAtToGesmewUsers < ActiveRecord::Migration
  def change
    Gesmew::User.reset_column_information
    unless Gesmew::User.column_names.include?("reset_password_sent_at")
      add_column :gesmew_users, :reset_password_sent_at, :datetime
    end
  end
end
