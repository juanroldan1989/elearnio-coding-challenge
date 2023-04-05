class CreateLearningPathCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_path_courses do |t|
      t.integer :learning_path_id, null: false
      t.integer :course_id, null: false

      t.timestamps
    end

    add_index :learning_path_courses, [:learning_path_id, :course_id], unique: true
  end
end
