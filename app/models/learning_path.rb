class LearningPath < ApplicationRecord
  validates :title, presence: true

  has_many :learning_path_courses, dependent: :destroy
  has_many :courses, -> { order("created_at DESC") }, through: :learning_path_courses
end
