class PagesController < ApplicationController

	before_action :get_projects

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

end
