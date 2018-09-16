class ChangeColumnNameFiveYearWorst < ActiveRecord::Migration[5.2]
  def change
		rename_column :portfolios, :five_year_worst, :two_year_worst
  end
end
