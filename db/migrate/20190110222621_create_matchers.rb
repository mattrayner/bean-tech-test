class CreateMatchers < ActiveRecord::Migration[5.2]
  def change
    create_table :matchers do |t|
      t.string :regex, null: false
      t.belongs_to :merchant

      t.timestamps
    end
  end
end
