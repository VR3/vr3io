class PagesController < ApplicationController

	before_action :get_projects

	def show
		render template: "#{params[:page]}"
	end

	private

	def get_projects
		@projects = Project.all.order("created_at desc")
	end

end
