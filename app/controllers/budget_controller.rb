class BudgetController < ApplicationController


  def index
    @months = %w'Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec'
    @years = %w'2017 2018'
    @number_of_months = 12
    @starting_month = 3

    incomes = Income.all

    @timeline = createTimeline(@years, @number_of_months, @starting_month, @months)
    # @incomes_for_months = getIncomesForMonth(@years, @months, incomes, @number_of_months, @starting_month)
    @incomes_for_months = getIncomesForMonth(@timeline, incomes)

    @patrickTotals = calculatePatrickTotal(@incomes_for_months)



    puts @timeline
  end


  private


  def getIncomesForMonth(timeline, incomes)
    incomes_for_months = Hash.new

    incomes.each do |income|

      incomes_for_months[income.id] = Hash.new

      timeline.each do |year, months|
        incomes_for_months[income.id][year] = Hash.new

        months.each do |month|
          date = Date.new(year.to_i, @months.index(month[:month]) + 1, -1)
          num_of_days = date.day
          weeks_in_month = num_of_days / 7.00
          hours_in_month = weeks_in_month * 40


          case income.interval
            when 'hour'
              incomes_for_months[income.id][year][month[:month]] = (hours_in_month * income.income.to_f).to_i
            when 'weekly'
              incomes_for_months[income.id][year][month[:month]] = (income.income.to_f * 4).to_i
            when 'fortnight'
              incomes_for_months[income.id][year][month[:month]] = (income.income.to_f * 2).to_i
            when 'monthly'
              incomes_for_months[income.id][year][month[:month]] = (income.income.to_f).to_i

          end
        end
      end
    end

    incomes_for_months
  end

  def calculatePatrickTotal(incomes_for_months)
    income = incomes_for_months.first
    patrickTotal = 54347

    totals = Array.new
    totals << patrickTotal

    income.second.each do |year, months|

      months.each do |month, amount|


          if month == 'Jul'
            totalAmount = amount
          else
            totalAmount = amount + totals[-1]
          end

          totals << totalAmount
      end
    end

    totals.shift
    totals
  end

  def createTimeline(years, number_of_months, starting_month, months)
    timeline = Hash.new

    # Find the amount of months per year
    years.each do |year|
      if number_of_months > 0

          if number_of_months >= months.length
            timeline[year] = months[starting_month-1..months.length]
            number_of_year_months = 12 - (starting_month - 1)
            starting_month = 1
          else
            timeline[year] = months[starting_month-1..number_of_months]
            number_of_year_months = number_of_months
          end

          number_of_months -= number_of_year_months

        end
    end

    timeline.each do |year, months|

      months.each_with_index do |month, index|
        days = Date.new(year.to_i, @months.index(month) + 1, -1).day
        hours = (days / 7.00 * 40.00).round(2)
        timeline[year][index] = {month: month, days: days, hours: hours}
      end
    end

    timeline
  end

end
