class ProjectsController < ApplicationController
	
    #require "paperclip/storage/ftp"
    
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@projects = Project.all.order("created_at asc")
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params
		@project.image = params[:project][:image]
		@project.video = params[:project][:video]

		if @project.save
			redirect_to @project
		else
			render "new"
		end

	end

	def show
		@project = Project.friendly.find(params[:id])
	end

	def edit
		@project = Project.friendly.find(params[:id])
		render 'edit'
	end

	def update
		@project = Project.friendly.find(params[:id])
		@project.image = params[:project][:image]
		@project.video = params[:project][:video]
		@project.update(project_params)
		redirect_to @project
	end

	def destroy
		@project = Project.friendly.find(params[:id])
		@project.destroy
		redirect_to root_path
	end


	private


	def project_params
		params.require(:project).permit(:title, :description, :link, :client, :provider, :date, :image, :video)
	end
end
