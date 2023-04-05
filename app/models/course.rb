class Course < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true

  belongs_to :author
  has_many :learning_path_courses
  has_many :learning_paths, through: :learning_path_courses
  has_many :talent_courses
  has_many :talents, through: :talent_courses
end
