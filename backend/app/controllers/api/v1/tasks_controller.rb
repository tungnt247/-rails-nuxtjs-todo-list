class Api::V1::TasksController < ApplicationController
  before_action :authenticate_request!
  before_action :load_task, only: %i[update complete destroy]
  respond_to :json

  def index
    tasks = current_user.tasks.order(:completed, created_at: :desc)
    render json: tasks
  end

  def create
    task = current_user.tasks.build(task_params)
    if task.save
      render json: task
    else
      render json: { error: task.errors.full_messages, status: :unprocessable_entry }
    end
  end

  def update
    if @task.update(task_params)
      render json: { task: @task, status: :ok }
    else
      render json: {
        task: @task.attribute_was(:content),
        errors: @task.errros.full_messages,
        status: :unprocessable_entry
      }
    end
  end

  def complete
    @task.toggle!(:completed)
    render json: @task
  end

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(%i[content])
  end

  def load_task
    @task = current_user.tasks.find_by(id: params[:id])
  end
end
