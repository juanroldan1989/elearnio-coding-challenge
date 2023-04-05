class CreateLearningPaths < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_paths do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    add_index :learning_paths, [:title], unique: true
  end
end
