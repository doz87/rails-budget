class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|

      t.string :name
      t.text :description
      t.integer :amount
      t.string :type

      t.timestamps
    end
  end
end
