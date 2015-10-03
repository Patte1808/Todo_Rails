class AddTitleToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :title, :text
  end
end
