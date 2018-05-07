class UsersController < ApplicationController

	def create
		user = User.create(user_params)
		unless user.valid?
			flash[:errors] = user.errors.full_messages
			return redirect_to root_path
		end
		session[:user_id] = user.id
		redirect_to groups_path
	end

	def user_params
		params.require(:user).permit(:fname, :lname, :email, :password)
	end
end
