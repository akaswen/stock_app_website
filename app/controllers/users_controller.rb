class UsersController < ApplicationController
	before_action :authenticate_user!

  def show
		@user = current_user
		@portfolios = @user.portfolios.paginate(page: params[:page])
  end

end
