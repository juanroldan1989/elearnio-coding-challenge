# == Schema Information
#
# Table name: talent_courses
#
# t.integer "talent_id", null: false
# t.integer "course_id", null: false

FactoryBot.define do
  factory :talent_course do
    talent
    course
  end
end
