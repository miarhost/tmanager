class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
 before_action :authenticate_user!
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
   @task = @project.tasks.find(params[:id])
  end


  def create
    @task = @project.tasks.build(task_params)
   if @task.save
    flash[:success] = 'Another task!'
     redirect_to project_path(@project)
   else
    redirect_to project_url(@project)
  end
  
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @project, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def sort_by_priority
  @tasks = Task.all
  respond_to do |format|
    @tasks.sort_by(&:priority)
    format.js { render :sort_by_priority, layout: false }
   end
  end

  private


  def set_project
   @project = Project.find(params[:project_id])
  end

      def set_task
      @task = Task.find(params[:id])
    end

  def task_params
     params.require(:task).permit(:name, :priority, :deadline, :done)
  end

end
