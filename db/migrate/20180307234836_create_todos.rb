class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos, id: :uuid do |t|
      t.string :title
      t.boolean :complete, default: false
      t.boolean :active, default: true
    end
  end
end
