class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    rename_column :users, :name, :username
    remove_column :users, :password_digest, :string
  end
end
