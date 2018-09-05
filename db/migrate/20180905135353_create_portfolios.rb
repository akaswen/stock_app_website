class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
			t.integer :initial_capital
			t.integer :one_year_average
			t.integer :one_year_worst_loss
			t.integer :one_year_best_gain
			t.integer :five_year_average
			t.integer :five_year_worst_loss
			t.integer :five_year_best_gain
			t.integer :ten_year_average
			t.integer :ten_year_worst_loss
			t.integer :ten_year_best_gain

      t.timestamps
    end
  end
end
