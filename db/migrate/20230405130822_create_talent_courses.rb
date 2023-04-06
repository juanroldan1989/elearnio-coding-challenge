class CreateTalentCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :talent_courses do |t|
      t.integer :talent_id, null: false
      t.integer :course_id, null: false

      t.timestamps
    end

    add_index :talent_courses, [:talent_id, :course_id], unique: true
  end
end
