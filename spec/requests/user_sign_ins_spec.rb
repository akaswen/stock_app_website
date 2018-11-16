require 'rails_helper'

RSpec.describe "UserSignIns", type: :request do

	context "users should be able to sign in" do
		
		before(:each) do
		 	@user = User.create!(name: "aaron", email: "aaron@example.com", password: "password", password_confirmation: "password") 
		end
		
		it "should change login and sign out links" do
			get root_path
			expect(response.body).not_to match /sign out/i
			expect(response.body.scan(/sign in/i).size).to eq(2) 
			my_sign_in(@user)
      expect(response).to redirect_to(root_url)
			follow_redirect!
			expect(response.body).to match /sign out/i
			expect(response.body.scan(/sign in/i).size).to eq(1) 
			my_sign_out(@user)
			get root_path
			expect(response.body).not_to match /sign out/i
			expect(response.body.scan(/sign in/i).size).to eq(2) 
		end
	end
end
