require 'rails_helper'

RSpec.describe Stock, type: :model do
	fixtures :users
	fixtures :portfolios
	fixtures :stocks
	before(:each) do
		@user = users(:aaron)
		@portfolio = @user.portfolios.build(name: "test", initial_capital: 50000)
		@stock1 = @portfolio.stocks.build(symbol: "goog", portfolio_percentage: 0.5)
		@portfolio.save
		@stock = @portfolio.stocks.build(symbol: "AAPL", portfolio_percentage: 0.5)
	end

	context 'a valid stock' do

		it 'will save' do
			expect(@stock.valid?).to be_truthy
		end

		it 'will uppercase the symbol' do
			@portfolio.save
			@portfolio.stocks.each do |stock|
				expect(stock.symbol.upcase).to eq(stock.symbol)
			end
		end
	end

	context 'an invalid stock' do

		it "won't save without a symbol" do
			@stock.symbol = ""
			expect(@stock.valid?).to be_falsey
		end

		it "won't save an improperly formatted symbol" do
			@stock.symbol = "1FD"
			expect(@stock.valid?).to be_falsey
		end

		it "won't save a symbol that is too long" do
			@stock.symbol = "a" * 11
			expect(@stock.valid?).to be_falsey
		end

		it "won't save without a percentage" do
			@stock.portfolio_percentage = ""
			expect(@stock.valid?).to be_falsey
		end
	end

	context "a stock's history" do

		it "will check for valid stock symbol" do
			@stock.symbol = "APPL"
			@stock.send(:check_hash_contents)
			expect(@stock.errors.any?).to be true
		end
		
		it "orders the hash_histories" do
			@stock.send(:check_hash_contents)
			result = @stock.sorted_hash_history
			result.length.times do |n| #check to make sure each item has a larger date than the next
				unless n+1 == result.length
					expect(result[n]["date"]).to be > result[n+1]["date"]
				end
			end
		end

		it "creates an array of closing values" do
			@stock.send(:check_hash_contents)
			sorted_hash_history = @stock.sorted_hash_history
			values_array = @stock.array_history
			expect(sorted_hash_history.length).to eq(values_array.length)
			values_array.length.times do |n|
				expect(values_array[n]).to eq(sorted_hash_history[n]["close"].to_f)
			end
		end
	end
end
