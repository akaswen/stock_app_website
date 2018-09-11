class Stock < ApplicationRecord
	belongs_to :portfolio
	validates :symbol, presence: true, format: { with: /\A[A-Za-z]+[-:\.]?[A-Za-z]*\Z/ }, length: { maximum: 10 }
	validates :portfolio_percentage, presence: true
end
