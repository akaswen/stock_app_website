require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
	describe "users can signup for the site" do

		before(:each) do
			@user = User.new(name: "aaron", email: "aaron@example.com", password: "password", password_confirmation: "password")
		end

		it "should render a signup page" do
			get sign_up_path
			expect(response).to render_template("devise/registrations/new")
		end

		it "should allow a new user to sign up" do
			expect {
				post sign_up_path, params: { user: { name: @user.name, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.to change { User.count }
			expect(response).to redirect_to(my_portfolios_path)
		end

		it "should not allow a new user to sign up with a bad email/password/name" do
			@user.email = "aaronexample.com"
			expect {
				post sign_up_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.not_to change{User.count}
		end

		it "should not allow a new user to sign up with an empty password" do
			@user.password = "  "
			expect {
				post sign_up_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.not_to change { User.count }
		end

		it "should not allow a new user to sign up without a name" do
			@user.name = ""
			expect {
				post sign_up_path, params: { user: { email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation } } }.not_to change { User.count }
		end
	end
end
