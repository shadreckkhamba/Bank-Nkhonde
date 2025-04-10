class RenamePhoneNumber2ToPhoneInUsers < ActiveRecord::Migration[7.1]
  def change
    execute "ALTER TABLE users RENAME COLUMN phone_number2 TO phone"
  end
end