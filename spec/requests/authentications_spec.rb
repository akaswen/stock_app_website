require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "Authentication for actions" do
		fixtures :users
		fixtures :portfolios

		before(:each) do
			@user = users(:aaron)
			@portfolio = portfolios(:one)
		end

    it "doesn't require authentication for portfolios index" do
			get portfolios_path
      expect(response).to have_http_status(200)
    end

		it "doesn't require authentication for portolio show" do
			get portfolio_path(@portfolio)
			expect(response).to have_http_status(200)
		end

		it "requires authentication for new portfolio" do
			get new_portfolio_path 
			expect(response).to redirect_to(root_path)
			sign_in(@user)
			get new_portfolio_path
			expect(response).to render_template(:new)
		end

		it "requires authentication for creating portfolios" do
			@portfolio = @user.portfolios.build(name: "test", initial_capital: 50000)
			@stock = @portfolio.stocks.build(symbol: "aapl", portfolio_percentage: 1)
			expect {
				post portfolios_path, params: { portfolio: { name: @portfolio.name, initial_capital: @portfolio.initial_capital, stocks_attributes: { "0": { symbol: @stock.symbol, portfolio_percentage: @stock.portfolio_percentage } } } } 
				}.to change { Portfolio.count }.by(0)
			sign_in(@user)
			expect {
				post portfolios_path, params: { portfolio: { name: @portfolio.name, initial_capital: @portfolio.initial_capital, stocks_attributes: { "0": { symbol: @stock.symbol, portfolio_percentage: @stock.portfolio_percentage } } } } 
				}.to change { Portfolio.count }.by(1)
		end

		it "requires authentication for deleting portfolios" do
			expect {
				delete portfolio_path(@portfolio)
			}.to change { Portfolio.count }.by(0)
			sign_in(@user)
			expect {
				delete portfolio_path(@portfolio)
			}.to change { Portfolio.count }.by(-1)
		end

		it "requires authentication for my portfolios page" do
			get my_portfolios_path
			expect(response).to redirect_to(root_path)
			sign_in(@user)
			get my_portfolios_path
			expect(response).to be_ok
		end
  end
end
