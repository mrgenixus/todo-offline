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

  def update
    todo = Todo.find(params[:id])
    todo.attributes = todo_params
    todo.active = true

    todo.save!

    render json: todo.as_json
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.attributes = { active: false}
    todo.save!

    render json: { success: true }
  end

  private

  def create_todo_params
    params.permit(:title, :complete, :id)
  end

  def update_todo_params
    params.permit(:title, :complete)
  end

  def todo_params
    send("#{params[:action]}_todo_params")
  end
end
