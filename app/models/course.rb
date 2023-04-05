class Course < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true

  belongs_to :author
  has_many :talent_courses
  has_many :talents, through: :talent_courses
end
