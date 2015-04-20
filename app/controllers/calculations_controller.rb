class CalculationsController < ApplicationController
    def word_count_form
        render 'word_count_form'
    end

    def word_count
        @text = params[:user_text]
        @special_word = params[:user_word]

        # ========================================================
        # Your code goes below.
        # The text the user input is in the string @text.
        # The special word the user input is in the string @special_word.
        # ========================================================

        @word_count = @text.split.length

        @character_count_with_spaces = @text.length

        @character_count_without_spaces = @text.gsub(" ","").length
        sanitized_text = @text.downcase
        sanitized_word = @special_word.downcase
        @occurrences = sanitized_text.split.count(sanitized_word)
        render 'word_count'
    end

    def loan_payment_form
        render 'loan_payment_form'
    end

    def loan_payment
        @apr = params[:annual_percentage_rate].to_f
        @years = params[:number_of_years].to_i
        @principal = params[:principal_value].to_f

        # =====================================================
        # Your code goes below.
        # You can use this formula for reference:
        # http://www.financeformulas.net/Loan_Payment_Formula.html
        # =====================================================

        present_value = @principal
        rate_per_period = @apr / 100 / 12
        number_periods = @years * 12

        @monthly_payment = (rate_per_period * present_value)/(1 - (1 + rate_per_period)**(-number_periods))
    end

    def time_between_form
        render 'time_between_form'
    end

    def time_between
        @starting = Chronic.parse(params[:starting_time])
        @ending = Chronic.parse(params[:ending_time])

        # =====================================================
        # Your code goes below.
        # The start time is in the Time @starting.
        # The end time is in the Time @ending.
        # The number of years the user input is in the integer @years.
        # =====================================================

        @seconds = @ending - @starting
        @minutes = @seconds/1.minutes
        @hours = @seconds/1.hours
        @days = @seconds/1.days
        @weeks = @seconds/1.weeks
        @months = @seconds/1.months
        @years = @seconds/1.years
        render 'time_between'
    end

    def descriptive_statistics_form
        render 'descriptive_statistics_form'
    end

    def descriptive_statistics
        @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

        # =====================================================
        # Your code goes below.
        # The numbers the user input are in the array @numbers.
        # =====================================================

        @sorted_numbers = @numbers.sort

        @count = @numbers.count

        @minimum = @numbers.min

        @maximum = @numbers.max

        @range = @maximum - @minimum

        if @count.odd?
          @median = @sorted_numbers[@count / 2]
        else
          @median = (@sorted_numbers[(@count / 2) - 1] + @sorted_numbers[(@count / 2)]) / 2
        end

        @sum = @numbers.sum

        @mean = @sum / @count

        squared_differences = []

        @numbers.each do |num|
          difference = num - @mean
          squared_difference = difference ** 2
          squared_differences.push(squared_difference)
        end

        @variance = squared_differences.sum / @count

        @standard_deviation = Math.sqrt(@variance)


        render  'descriptive_statistics'
    end
end
