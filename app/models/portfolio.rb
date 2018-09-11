class Portfolio < ApplicationRecord
	belongs_to :user
	has_many :stocks, dependent: :destroy
	accepts_nested_attributes_for :stocks
	validates_presence_of :stocks, :name, :initial_capital
	before_save :saves_stocks
	before_validation :correct_percents

	#private
	
		def saves_stocks
			errors.add(:stocks, "Not valid") unless stocks.each { |stock| stock.save }
		end

		def correct_percents
			total = stocks.inject(0.0) { |sum, stock| sum + stock.portfolio_percentage }
			total == 1.0 ? true : errors.add(:stocks, "Incorrect percentages")
		end
end
