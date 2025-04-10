class CreateContributions < ActiveRecord::Migration[7.1]
  def change
    create_table :contributions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.decimal :amount
      t.datetime :date
      t.string :status

      t.timestamps
    end
  end
end
