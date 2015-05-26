class AddActivationTokenToStatus < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string
    add_column :users, :Activation_status, :string
  end
end
