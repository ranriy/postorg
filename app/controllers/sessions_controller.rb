class SessionsController < ApplicationController
	def new
	end

	def create
		user=User.find_by(email: params[:email].downcase)
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			return redirect_to groups_path
		end
		flash[:errors] = ['Incorrect email or password']
		redirect_to root_path
	end

	def destroy
    	session.delete(:user_id) if session[:user_id]
    	redirect_to root_path
  	end
end
