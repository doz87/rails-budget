class CreateImports < ActiveRecord::Migration[5.0]
  def change
    create_table :imports do |t|

      t.datetime :date
      t.float :amount
      t.text :description
      t.string :keywords

      t.references :expense_category

      t.timestamps
    end
  end
end
