class AddGroupIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :group_id, :bigint
  end
end
