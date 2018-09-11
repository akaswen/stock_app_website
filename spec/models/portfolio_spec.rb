require 'rails_helper'

RSpec.describe Portfolio, type: :model do
	fixtures :users
	before(:each) do 
		@user = users(:aaron)
		@portfolio = @user.portfolios.build(name: "test", initial_capital: 50000)
		@stock1 = @portfolio.stocks.build(symbol: "ABD", portfolio_percentage: 0.5)
		@stock2 = @portfolio.stocks.build(symbol: "APPL", portfolio_percentage: 0.5)
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
		it "can be saved" do
			expect(@portfolio.valid?).to be true
			expect{@portfolio.save}.to change{Portfolio.count}.by(1)
		end

		it "can save stocks" do
			@portfolio.stocks.each do |stock|
				expect(stock.valid?).to be true
			end
			expect { @portfolio.save }.to change {Stock.count}.by(2)
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
end
