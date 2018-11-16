module SignInHelpers
	def my_sign_in(user)
		post sign_in_path, params: { user: { email: user.email, password: user.password } }
	end

	def my_sign_out(user)
		delete sign_out_path(user)
	end
end
