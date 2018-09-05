require 'rails_helper'

RSpec.describe "UserSignIns", type: :request do

	describe "users should be able to sign in" do
		
		before(:each) do
		 	@user = User.create!(email: "aaron@example.com", password: "password", password_confirmation: "password") 
		end
		
		it "should sign in a user in and out" do
			get sign_in_path
			expect(response).to render_template("devise/sessions/new")
			post sign_in_path, params: { user: { email: @user.email, password: @user.password } }
			expect(response).to redirect_to(root_url)
			follow_redirect!
			expect(response.body).to have_link('logout', sign_out_path)
			delete sign_out_path(@user)
			expect(response).to redirect_to(sign_in_path)
			follow_redirect!
			expect(response.body).not_to have_link('logout', sign_out_path)
		end
	end
end
