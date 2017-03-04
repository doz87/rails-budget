class IncomeController < ApplicationController

  def index
    @incomes = Income.all

  end

  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params)

    if @income.save
      redirect_to income_index_path
    end
  end


  def show
    @income = Income.find(params[:id])
  end



  private

  def income_params
    params.require(:income).permit(:name, :income, :interval, :tax)
  end

end
