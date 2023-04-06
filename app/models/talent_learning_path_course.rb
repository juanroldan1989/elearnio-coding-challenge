class TalentLearningPathCourse < ApplicationRecord
  STAND_BY = 0
  IN_PROGRESS = 1
  COMPLETED = 2

  validates :talent_id, presence: true
  validates :learning_path_id, presence: true

  belongs_to :talent
  belongs_to :learning_path
  belongs_to :course
end
