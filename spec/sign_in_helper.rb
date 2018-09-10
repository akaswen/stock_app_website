module SignInHelpers
	def sign_in(user)
		post sign_in_path, params: { user: { email: user.email, password: user.password, password_confirmation: user.password } }
	end

	def sign_out(user)
		delete sign_out_path(user)
	end
end
