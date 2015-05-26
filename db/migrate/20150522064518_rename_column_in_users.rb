class RenameColumnInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :Activation_status, :activation_status
  end
end
