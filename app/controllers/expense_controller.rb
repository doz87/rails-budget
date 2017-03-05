class ExpenseController < ApplicationController
  require 'csv'

  def index
    @expenses = Expense.all
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

      csv_text = File.read($file)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Moulding.create!(row.to_hash)
      end
    end


  end
end
