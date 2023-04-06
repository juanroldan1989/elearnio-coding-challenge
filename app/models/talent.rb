class Talent < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, uniqueness: {
    scope: :last_name, message: "combined with Last name already exists"
  }

  has_many :talent_courses
  has_many :courses, through: :talent_courses
  has_many :talent_learning_path_courses
  has_many :learning_paths, through: :talent_learning_path_courses
end
