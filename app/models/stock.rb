class Stock < ApplicationRecord
	attr_accessor :hash_history_array
	belongs_to :portfolio
	validates :symbol, presence: true, format: { with: /\A[A-Za-z]+[-:\.]?[A-Za-z]*\Z/ }, length: { maximum: 10 }
	validates :portfolio_percentage, presence: true
	before_validation :check_hash_contents unless Rails.env.test?
	before_save :upcase
	
	def sorted_hash_history
		hash_history_array.sort_by { |hash| hash["date"] }
		hash_history_array.reverse
	end

	def array_history #pulls the closing values out of each datum entry and puts it into an array
		array = self.sorted_hash_history
		array.map! do |item|
			item = item["close"].to_f
		end
		array
	end

	private
		
		def upcase
			self.symbol = symbol.upcase
		end

		def get_hash_history
			uri = URI("https://api.iextrading.com/1.0/stock/#{self.symbol}/chart/5y")
			Net::HTTP.get(uri)
		end

		def check_hash_contents
			history_string = get_hash_history
			if history_string == "Unknown symbol"
				self.errors.add(:hash, "records for #{symbol} not found") 
			else
				self.hash_history_array = JSON.parse(history_string)
			end
		end
end
