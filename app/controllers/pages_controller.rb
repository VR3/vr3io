class PagesController < ApplicationController

	before_action :get_projects, :get_jobs, :get_articles

	def show
		render template: "/pages/#{params[:page]}"
	end

	def send_mail
		name = params[:name]
		email = params[:email]
		body = params[:body]
		ContactMailer.contact_email(name, email, body).deliver
		redirect_to root_path, notice: "Mensaje enviado"
	end

	private

	def get_projects
		@projects = Project.all.order("created_at desc")
	end

	def get_jobs
		@jobs = Job.all.order("created_at desc")
	end

	def get_articles
		@articles = Article.all.order("created_at desc")
	end

end
