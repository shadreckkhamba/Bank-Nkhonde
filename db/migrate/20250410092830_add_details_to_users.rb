class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone_number2, :string
    add_column :users, :gender, :string
    add_column :users, :role, :string
  end
end
