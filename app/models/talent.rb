class Talent < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, uniqueness: {
    scope: :last_name, message: "combined with Last name already exists"
  }
end
