class Course < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true

  has_many :talent_courses
  has_many :talents, through: :talent_courses
end
