require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
	describe "users can signup for the site" do

		before(:each) do
			@user = User.new(email: "aaron@example.com", password: "password", password_confirmation: "password")
		end

		it "should render a signup page" do
			get new_user_registration_path
			expect(response).to render_template("devise/registrations/new")
		end

		it "should allow a new user to sign up" do
			expect {
				post user_registration_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.to change { User.count }
			@user = User.find_by(email: @user.email)
			expect(response).to redirect_to(user_path(@user))
		end
	end
end
