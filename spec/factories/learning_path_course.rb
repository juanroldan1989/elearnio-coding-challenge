# == Schema Information
#
# Table name: learning_path_courses
#
# t.integer "learning_path_id", null: false
# t.integer "course_id", null: false

FactoryBot.define do
  factory :learning_path_course do
    learning_path
    course
  end
end
