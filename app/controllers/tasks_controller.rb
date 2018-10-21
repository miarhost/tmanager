class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token
 #before_action :set_project, only: [:create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
     @tasks.sort_by(&:priority)
  end
  def new
    @task = Task.new
  end

  def show
  @task = Task.find(params[:id])
  end

  def edit
     @task = Task.find(params[:id])
  end


  def create

   @task = Task.new(task_params)
  @task.project_id = params[:project_id]
#@task.user_id = current_user.id
 @task.save
if @task.save
 flash[:success] = 'Another task!'
redirect_to projects_url
 else
  redirect_to tasks_path
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

  private

    def set_task
      @task = Task.find(params[:id])
    end

#def set_project
#@project = Project.find(params[:project_id])
#end

    def task_params
      params.require(:task).permit(:name, :priority, :deadline, :done, :project_id)
    end
end
