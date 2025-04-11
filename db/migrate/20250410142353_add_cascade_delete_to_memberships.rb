class AddCascadeDeleteToMemberships < ActiveRecord::Migration[6.0]
  def change
    # Remove the existing foreign key if it exists
    remove_foreign_key :memberships, :users

    # Add the foreign key with ON DELETE CASCADE
    add_foreign_key :memberships, :users, on_delete: :cascade
  end
end