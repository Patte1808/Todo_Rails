class TodosController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @todos = user_todos
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    @todo.save

    respond_to do |format|
      format.html { redirect_to root_path }

      format.js {}
    end
  end

  def show
    @todo = current_todo
  end

  def edit
    @todo = current_todo
  end

  def update
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to todo_path(@todo)

    else
      redirect_to todos_path
    end
  end

  def destroy
    @todo = current_todo
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to root_path }

      format.js {}
    end
  end

  def complete
    @todo = current_todo
    @todo.is_done = !@todo.is_done

    @todo.save

    respond_to do |format|
      format.html { redirect_to root_path }

      format.js {}
    end
  end

  private

  def user_todos
    Todo.where(:user_id => current_user.id)
  end

  def current_todo_id
    params[:id]
  end

  def current_todo
    Todo.find(current_todo_id)
  end

  def todo_params
    params[:todo].permit(:title, :description, :due_date)
  end
end
