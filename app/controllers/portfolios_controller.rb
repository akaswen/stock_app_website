class PortfoliosController < ApplicationController
  def new
		#@portfolio = current_user.portfolios.build
		#@stock = @portfolio.stocks.build
  end

	def create
		#portfolio = current_user.portfolios.build(portfolio_params)
		#@portfolio.save
		#debugger	
	end

	private

	def portfolio_params
		params.require(:portfolio).permit(:name, :initial_capital, stocks_attributes: [:name, :symbol, :portfolio_percentage])
	end
end
