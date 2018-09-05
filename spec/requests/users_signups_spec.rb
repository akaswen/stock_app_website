require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
	describe "users can signup for the site" do

		before(:each) do
			@user = User.new(email: "aaron@example.com", password: "password", password_confirmation: "password")
		end

		it "should render a signup page" do
			get sign_up_path
			expect(response).to render_template("devise/registrations/new")
		end

		it "should allow a new user to sign up" do
			expect {
				post sign_up_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.to change { User.count }
			@user = User.find_by(email: @user.email)
			expect(response).to redirect_to(user_path(@user))
		end

		it "should not allow a new user to sign up with a bad email/password" do
			@user.email = "aaronexample.com"
			expect {
				post sign_up_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.not_to change{User.count}
			@user.email = "aaron@example.com"
			@user.password = "  "
			expect {
				post sign_up_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.not_to change { User.count }
		end
	end
end
