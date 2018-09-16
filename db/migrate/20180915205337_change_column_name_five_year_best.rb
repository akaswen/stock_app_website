class ChangeColumnNameFiveYearBest < ActiveRecord::Migration[5.2]
  def change
		rename_column :portfolios, :five_year_best, :two_year_best
  end
end
