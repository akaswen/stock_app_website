class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
			t.integer :initial_capital
			t.integer :one_year_average
			t.integer :one_year_worst
			t.integer :one_year_best
			t.integer :three_year_average
			t.integer :three_year_worst
			t.integer :three_year_best
			t.integer :five_year_average
			t.integer :five_year_worst
			t.integer :five_year_best

      t.timestamps
    end
  end
end
