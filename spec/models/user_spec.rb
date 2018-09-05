require 'rails_helper'

RSpec.describe User, type: :model do
	context 'validation tests' do

		before(:each) do
			@user = User.new(email: "aaron@example.com", password: "password", password_confirmation: "password")
		end

		it 'should be valid' do
			expect(@user.valid?).to eq(true)
		end

		it 'should not be valid without email' do
			@user.email = "   "
			expect(@user.valid?).to eq(false)
		end

		it 'should not be valid without password or password confirmation' do
			@user.password = "   "
			expect(@user.valid?).to eq(false)
			@user.password = "password"
			@user.password_confirmation = "   "
			expect(@user.valid?).to eq(false)
		end	

		it 'should not be valid when password and confirmation dont match' do
			@user.password_confirmation = "foobar"
			expect(@user.valid?).to eq(false)
		end
	end
end
