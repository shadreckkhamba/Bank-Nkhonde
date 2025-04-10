class AddJoinCodeToGroups < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :join_code, :string, null: false
    add_index :groups, :join_code, unique: true
  end
end