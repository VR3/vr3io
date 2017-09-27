class ProjectsController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@filterrific = initialize_filterrific(
			Project,
			params[:filterrific]
		) or return
		@projects = Project.all.order("created_at desc")
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new project_params
		@project.image = params[:project][:image]
		@project.video = params[:project][:video]

		if @project.save!
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
		if params[:project][:image].exists?
			@project.image = params[:project][:image]
		end
		
		if params[:project][:video].exists?
			@project.video = params[:project][:video]
		end
		@project.update(project_params_for_update)
		redirect_to @project
	end

	def destroy
		@project = Project.friendly.find(params[:id])
		@project.destroy
		redirect_to root_path
	end

	private

	def project_params
		params.require(:project).permit(:title, :description, :link, :client, :provider, :date, :category, :image, :video)
	end

	def project_params_for_update
		params.require(:project).permit(:title, :description, :link, :client, :provider, :date, :category)
	end
end
