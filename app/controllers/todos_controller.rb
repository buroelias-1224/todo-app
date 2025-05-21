class TodosController < ApplicationController
  before_action :set_todo, only: [ :show, :edit, :update, :destroy, :toggle_complete ]

  def index
    @todos = Todo.all
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Todo was successfully created."
    else
      render :new
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_url, notice: "Todo was successfully destroyed."
  end

  def toggle_complete
    @todo.update(completed: !@todo.completed)
    redirect_to todos_path
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:title, :completed)
    end
end
