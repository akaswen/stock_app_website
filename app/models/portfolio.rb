class Portfolio < ApplicationRecord
	belongs_to :user
	has_many :stocks, dependent: :destroy
	accepts_nested_attributes_for :stocks
end
