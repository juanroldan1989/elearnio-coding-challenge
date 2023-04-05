class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description
      t.integer :author_id, null: false

      t.timestamps
    end

    add_index :courses, [:title], unique: true
  end
end
