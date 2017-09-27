class ProjectsController < ApplicationController
    
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@filterrific = initialize_filterrific(
			Project,
			params[:filterrific],
			select_options: {
				with_category: Project.options_for_select
			},
			:persistence_id => false,
			default_filter_params: {},			
		) or return
		@projects = @filterrific.find.page(params[:page])
		
		respond_to do |format|
			format.html
			format.js
		end
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
