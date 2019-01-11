class CreateMerchants < ActiveRecord::Migration[5.2]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.belongs_to :merchant

      t.timestamps
    end
  end
end
