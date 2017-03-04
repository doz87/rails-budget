class CreateIncomes < ActiveRecord::Migration[5.0]
  def change
    create_table :incomes do |t|

      t.string :name
      t.string :income
      t.string :interval
      t.string :tax

      t.timestamps
    end
  end
end
