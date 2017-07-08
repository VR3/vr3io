class ProjectsController < ApplicationController
	
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@projects = Project.all.order("created_at asc")
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params
		@project.project_image = params[:project][:project_image]
		@project.project_video = params[:project][:project_video]

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
		@project.project_image = params[:project][:project_image]
		@project.project_video = params[:project][:project_video]
		@project.update(project_params)
		redirect_to @project
	end

	def destroy
		@project = Project.friendly.find(params[:id])
		@project.destroy
		redirect_to 'index', notice: "Puesto de Trabajo borrado exitosamente"
	end


	private


	def project_params
		params.require(:project).permit(:title, :description, :link, :client, :provider, :date, :project_image, :project_video)
	end
end
