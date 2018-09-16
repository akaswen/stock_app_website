class PortfoliosController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@portfolios = Portfolio.all
	end

  def new
		@portfolio = current_user.portfolios.build
		10.times { @stock = @portfolio.stocks.build }
  end

	def create
		@portfolio = current_user.portfolios.build(portfolio_params)
		if @portfolio.save
			redirect_to @portfolio
		else
			render 'new'
		end
	end

	def show
		@portfolio = Portfolio.find(params[:id])
	end

	def destroy
		@portfolio = Portfolio.find(params[:id])
		@portfolio.destroy
		redirect_to request.referer unless Rails.env.test?
	end

	private

	def portfolio_params
		params.require(:portfolio).permit(:name, :initial_capital, stocks_attributes: [:symbol, :portfolio_percentage])
	end
end
