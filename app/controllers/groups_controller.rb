class GroupsController < ApplicationController
	
	def index
		@user = User.find(session[:user_id])
		@groups = Organization.all
	end

	def create
		group = Organization.create(group_params)
		unless group.valid?
			flash[:error] = group.errors.full_messages
			return redirect_to groups_path
		end
		group.user_id = session[:user_id]
		group.members = 1
		group.save
		#yaha par joi table me bhi entry karna h
		group.users << User.find(session[:user_id])
		redirect_to groups_path
	end

	def display
		@group = Organization.find(params[:id]) 
		@user = User.find(session[:user_id])
		@members = @group.users.all
		p @members
	end

	def delete
		group = Organization.find(params[:id])
		group.destroy
		redirect_to groups_path
	end

	def add
		group = Organization.find(params[:id])
		group.users << User.find(session[:user_id])
		group.members = group.members + 1
		group.save
		redirect_to groups_path
	end

	def remove
		user = User.find(session[:user_id])
		group = user.organizations.find(params[:id])
		group.members = group.members - 1
		group.save
		user.organizations.delete(group) if group
		redirect_to groups_path
	end

	def group_params
		params.require(:group).permit(:name, :description)
	end
end
