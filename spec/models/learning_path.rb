# frozen_string_literal: true

require "rails_helper"

RSpec.describe LearningPath, type: :model do
  subject { build(:learning_path) }

  describe "associations" do
    it { is_expected.to have_many :learning_path_courses }
    it { is_expected.to have_many(:courses).through(:learning_path_courses) }
    it { is_expected.to have_many :talent_learning_path_courses }
    it { is_expected.to have_many(:talents).through(:talent_learning_path_courses) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :title }
  end
end
