class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :priority
      t.references :project, foreign_key: true
      t.datetime :deadline
      t.boolean :done

      t.timestamps
    end
  end
end
