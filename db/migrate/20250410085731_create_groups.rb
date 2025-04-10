class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.decimal :contribution_amount
      t.decimal :total_amount

      t.timestamps
    end
  end
end
