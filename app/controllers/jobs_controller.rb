class JobsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.all.order("created_at desc")
  end
  
  def new
    @job = Job.new
  end

  def create
    @job = Job.new job_params
    @job.picture = params[:job][:picture]

    if @job.save!
      redirect_to @job, notice: "Puesto de Trabajo creado exitosamente"
    else
      render "new"
    end
  end

  def show
    @job
  end

  def edit
    @job
    render 'edit'
  end

  def update
    if params[:job][:picture]
      @job.picture = params[:job][:picture]
    end
    @job.update(job_params)
    redirect_to @job
  end

  def destroy
    @job.destroy
    redirect_to 'index', notice: "Puesto de Trabajo borrado exitosamente"
  end

  private

  def set_job
    @job = Job.friendly.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:position, :location, :salary, :overview, :qualifications, :responsabilities, :picture)
  end

end
