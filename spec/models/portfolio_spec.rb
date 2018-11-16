require 'rails_helper'

RSpec.describe Portfolio, type: :model do
	fixtures :users
	fixtures :portfolios
	fixtures :stocks

	before(:each) do 
		@user = users(:aaron)
		@portfolio = @user.portfolios.build(name: "test", initial_capital: 50000)
		@stock1 = @portfolio.stocks.build(symbol: "GOOG", portfolio_percentage: 0.5)
		@stock2 = @portfolio.stocks.build(symbol: "AAPL", portfolio_percentage: 0.5)
	end
	
	context "is related to stocks" do
		it "has a stocks method" do
			expect(@portfolio).to respond_to(:stocks)
		end
		
		it "validates stocks" do 
			@portfolio.stocks = []
			expect(@portfolio.valid?).to be_falsey
			expect{ @portfolio.save }.to change{Portfolio.count}.by(0)
		end
	end

	context "has validations" do
		it "can be saved and save stocks" do
			expect(@portfolio.valid?).to be true
			portfolio_count = Portfolio.count
			stock_count = Stock.count
			@portfolio.save
			expect(Portfolio.count).to eq(portfolio_count + 1)
			expect(Stock.count).to eq(stock_count + 2)
		end

		it "validates name" do 
			@portfolio.name = ""
			expect(@portfolio.valid?).to be_falsey
			expect{@portfolio.save}.to change{Portfolio.count}.by(0)
		end

		it "validates initial capital" do 
			@portfolio.initial_capital = ""
			expect(@portfolio.valid?).to be_falsey
			expect{@portfolio.save}.to change{Portfolio.count}.by(0)
		end
	end

	context "it checks the stocks" do
		
		it "doesn't save with invalid stocks" do
			@stock1.symbol = ""
			expect{@portfolio.save}.to change{Portfolio.count}.by(0)
		end	

		it "doesn't save invalid percentages" do
			@stock1.portfolio_percentage = 0.2
			expect{@portfolio.save}.to change{Portfolio.count}.by(0)
		end
	end

	context "calculates values" do

		it "builds a balanced history array" do
			@portfolio = portfolios(:one)
			@stock1 = @portfolio.stocks.first
			@stock1.update_attribute(:portfolio_percentage, 0.5)
			@stock2 = @portfolio.stocks.create(symbol: "test", portfolio_percentage: 0.5)
			allow(@stock1).to receive(:array_history) { [10, 11, 111, 124, 15, 15] }
			allow(@stock2).to receive(:array_history) { [10, 11, 11] } 
			expect(@stock2.array_history.length).to be < @stock1.array_history.length
			array = []
			array << @stock1.array_history
			array << @stock2.array_history
			array.sort_by! { |history_array| history_array.length }
			shortest_length = array[0].length
			array.map! { |history_array| history_array = history_array[0..shortest_length-1] } 
			expect(array[0].length).to eq(array[1].length)
		end

		it "can calculate the final numbers" do
			@stock1.send(:check_hash_contents)
			@stock2.send(:check_hash_contents)
			@portfolio.send(:calculate_attributes)
      expect(@portfolio.one_year_average).to_not be nil
			expect(@portfolio.one_year_worst).to_not be nil
			expect(@portfolio.one_year_best).to_not be nil
			expect(@portfolio.three_year_average).to_not be nil
			expect(@portfolio.three_year_worst).to_not be nil
			expect(@portfolio.three_year_best).to_not be nil
			expect(@portfolio.two_year_average).to_not be nil
			expect(@portfolio.two_year_worst).to_not be nil
			expect(@portfolio.two_year_best).to_not be nil
		end
	end
end
