class AddPortfolioIdToStocks < ActiveRecord::Migration[5.2]
  def change
    add_reference :stocks, :portfolio, foreign_key: true
  end
end
