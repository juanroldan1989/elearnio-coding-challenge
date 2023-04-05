class CreateTalentCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :talent_courses do |t|
      t.integer :talent_id, null: false
      t.integer :course_id, null: false

      t.timestamps
    end
  end
end
