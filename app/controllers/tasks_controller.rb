class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authorize_task, only: [:show, :update, :destroy]

  def index
    render json: Task.all
    # render json: current_user.tasks, status: :success
  end

  def show
    render json: @task, status: :ok
  end

  def create
    @task = Task.new(task_params.merge(user: current_user))
    if @task.save
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.soft_delete
      render json: :no_content, status: :ok
    else
      render json: :no_content, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :status, :description, :end_time, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def authorize_task
    authorize @task
  end

end
