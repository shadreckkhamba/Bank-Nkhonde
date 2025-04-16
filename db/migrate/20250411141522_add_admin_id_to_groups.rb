class AddAdminIdToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :admin_id, :integer
  end
end
