class Course < ApplicationRecord
  validates :author_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: true
end
