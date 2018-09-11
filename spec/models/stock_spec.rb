require 'rails_helper'

RSpec.describe Stock, type: :model do
	fixtures :users
	before(:each) do
		@user = users(:aaron)
		@portfolio = @user.portfolios.build(name: "test", initial_capital: 50000)
		@stock1 = @portfolio.stocks.build(symbol: "ABD", portfolio_percentage: 0.5)
		@portfolio.save
		@stock = @portfolio.stocks.build(symbol: "APPL", portfolio_percentage: 0.5)
	end

	context 'a valid stock' do

		it 'will save' do
			expect(@stock.valid?).to be_truthy
		end

		it 'will uppercase the symbol' do
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
end
