class Portfolio < ApplicationRecord
	belongs_to :user
	has_many :stocks, dependent: :destroy
	accepts_nested_attributes_for :stocks
	validates_presence_of :stocks, :name, :initial_capital
	before_save :saves_stocks
	before_save :calculate_attributes unless Rails.env.test?
	before_validation :correct_percents

	def balanced_history # makes stock histories same length and returns array
		array = []
		self.stocks.each { |stock| array << [stock.portfolio_percentage, stock.array_history] }
		array.sort_by! { |history_array| history_array[1].length }
		shortest_length = array[0][1].length
		array = array.map do |history_array| 
			[history_array[0], history_array[1][0..shortest_length - 1].reverse]
		end
		array
	end


	private
	
		def saves_stocks
			errors.add(:stocks, "Not valid") unless stocks.each { |stock| stock.save }
		end

		def correct_percents
			total = stocks.inject(0.0) { |sum, stock| sum + stock.portfolio_percentage }
			total == 1.0 ? true : errors.add(:stocks, "Incorrect percentages")
		end

		def calculate_attributes
			self.one_year_average = average(252)
			self.one_year_worst = worst(252)
			self.one_year_best = best(252)
			if self.balanced_history[0][1].length >= 504
				self.two_year_average = average(504)
				self.two_year_worst = worst(504)
				self.two_year_best = best(504)
			end
			if self.balanced_history[0][1].length >= 756 
				self.three_year_average = average(756)
				self.three_year_worst = worst(756)
				self.three_year_best = best(756)
			end
		end

		def average(n)
			stocks_histories = self.balanced_history
			totals = calculate_totals(n, stocks_histories)
			average_end_amount = totals.sum / totals.length
			average_end_amount - self.initial_capital
		end

		def worst(n)
			stocks_histories = balanced_history
			totals = calculate_totals(n, stocks_histories)
			average_end_amount = totals.sort.first
			average_end_amount - self.initial_capital
		end

		def best(n)
			stocks_histories = balanced_history
			totals = calculate_totals(n, stocks_histories)
			average_end_amount = totals.sort.last
			average_end_amount - self.initial_capital
		end

    def calculate_totals(weeks, stocks)
			i = 0
			result = []
			until i + weeks >= stocks[0][1].length
				capital = 0
				stocks.each do |stock|
					money_for_stock = ((self.initial_capital * stock[0]) * 100).to_i / 100.0
					shares_for_stock = (money_for_stock / stock[1][i]).to_i
					final_money = (shares_for_stock * stock[1][i + weeks]).to_i
					capital += final_money
				end
				result << capital

				i += 1
			end
			result
		end
end
