class ChangeUserColumnName < ActiveRecord::Migration[4.2]
  def change
    rename_column :users, :reset_password_token, :tgToken
    rename_column :users, :reset_password_sent_at, :bearerToken
  end
end
