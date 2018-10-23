class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_project

  def index
    @tasks = Task.all
   
  end

  def show
  @task = Task.find(params[:id])
  end
  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end


  def create
    @task = @project.tasks.create(task_params)
   if @task.save
    flash[:success] = 'Another task!'
     redirect_to project_task_url(@project, @task)
   else
    redirect_to project_url(@project)
  end
  
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
   @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@task.project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def sort_by_priority
  @tasks = @project.tasks.all
  respond_to do |format|
    @tasks.sort_by(&:priority)
    format.js { render :sort_by_priority, layout: false }
   end
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

  def set_project
   @project = Project.find(params[:project_id])
  end

  def task_params
     params.require(:task).permit(:name, :priority, :deadline, :done)
  end

end
