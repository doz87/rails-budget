class ExpenseCategory < ApplicationRecord

  has_many :expenses
  has_many :imports

end
