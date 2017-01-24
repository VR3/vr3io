class ProjectsController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	#before_action :find_project, only: [:show, :edit, :update, :destroy]
	before_action :friendly_find_project, only: [:show, :edit, :update, :destroy]

	def index
		@projects = Project.all.order("created_at -desc")
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params

		if @project.save
			redirect_to @project, notice: "Proyecto exitosamente guardado"
		else
			render "new"
		end

	end

	def show
		@project = Project.friendly.find(params[:id])
		#@project = Project.find(params[:id])
	end

	def edit
		@project = Project.friendly.find(params[:id])
		#@project = Project.find(params[:id])
		render 'edit'
	end

	def update
		@project = Project.friendly.find(params[:id])
		#@project = Project.find(params[:id])
		@project.update(project_params)
		redirect_to @project
	end

	private

	def find_project
		@project = Project.find(params[:id])
	end

	def friendly_find_project
		@project = Project.friendly.find(params[:id])
	end


	def project_params
		params.require(:project).permit(:title, :description, :link)
	end

end
