class ExpenseCategoryController < ApplicationController

  def new
    @expense_category = ExpenseCategory.new
    @import_id = params[:import_id]
  end

  def create
    @expense_category = ExpenseCategory.new(expense_category_params)
    @import = Import.find(params[:import_id])


    if (@expense_category.save)
      @import.update_attribute(:expense_category_id, @expense_category.id)

      redirect_to expense_path
    end
  end

  def show
  end

  def delete
  end

  def update
  end


  private

  def expense_category_params
    params.require(:expense_category).permit(:name, :description)
  end

end
