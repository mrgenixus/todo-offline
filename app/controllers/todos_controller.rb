class TodosController < ApplicationController
  respond_to :json

  def create
    todo = Todo.new todo_params
    todo.save!

    render json: todo.as_json
  end

  def index
    render json: Todo.active.as_json
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.attributes = { active: false}
    todo.save!

    render json: { success: true }
  end

  private

  def todo_params
    params.permit(:title, :complete)
  end
end
