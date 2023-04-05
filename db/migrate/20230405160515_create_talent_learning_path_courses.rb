class CreateTalentLearningPathCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :talent_learning_path_courses do |t|
      t.integer :talent_id, null: false
      t.integer :learning_path_id, null: false
      t.integer :course_id, null: false
      t.integer :course_status, default: 0

      t.timestamps
    end

    add_index :talent_learning_path_courses,
      [:talent_id, :learning_path_id, :course_id],
      unique: true,
      name: "index_on_talent_id_and_learning_path_id_and_course_id"
  end
end
