class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :description, null: false
      t.belongs_to :matcher
      t.belongs_to :merchant

      t.timestamps
    end
  end
end
