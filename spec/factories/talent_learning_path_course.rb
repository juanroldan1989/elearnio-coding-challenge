# == Schema Information
#
# Table name: talent_learning_path_courses
#
# t.integer "talent_id", null: false
# t.integer "learning_path_id", null: false
# t.integer "course_id", null: false
# t.integer "course_status", default: 0

FactoryBot.define do
  factory :talent_learning_path_course do
    talent
    learning_path
    course
    course_status { TalentLearningPathCourse::STAND_BY }
  end
end
