class ExpenseController < ApplicationController
  require 'csv'

  def index

    @expense_categories = ExpenseCategory.all
    @expenses = Expense.all
    @imports = Import.where(expense_category_id: nil)
  end

  def new
    @expense = Expense.new
  end

  def update
  end

  def edit
  end

  def show
  end


  def import
    @file = params[:file]

    if @file
      month_date = Date.parse(params[:month])
      start_date = month_date
      end_date = Date.new(month_date.year, month_date.month, -1)


      csv_text = File.read(@file.tempfile)
      csv = CSV.parse(csv_text, :headers => false)
      csv.each do |row|
        date = Date.parse(row[0])
        amount = row[1]

        next if date > end_date || date < start_date
        next if amount.to_f > 0


        keywords = row[2].split(' ')

        Import.create(
            date: date,
            amount: amount.to_f,
            keywords: keywords.join(',')
        )

        p row
      end
    end


  end
end
