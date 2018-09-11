require 'rails_helper'

RSpec.describe Portfolio, type: :model do
	context "is related to stocks" do
		fixtures :users
		before(:each) do 
			@user = users(:aaron)
			@portfolio = @user.portfolios.build
			@stock1 = @portfolio.stocks.build
			@stock2 = @portfolio.stocks.build
		end

		it "has a stocks method" do
			expect(@portfolio).to respond_to(:stocks)
		end

		it "can be saved" do
			expect(@portfolio.valid?).to be true
			expect{@portfolio.save}.to change{Portfolio.count}.by(1)
		end

	end
end
