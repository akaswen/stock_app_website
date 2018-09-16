class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
		rename_column :portfolios, :five_year_average, :two_year_average
  end
end
