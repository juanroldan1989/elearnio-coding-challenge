# frozen_string_literal: true

require "rails_helper"

RSpec.describe LearningPathCourse, type: :model do
  subject { build(:learning_path_course) }

  describe "associations" do
    it { is_expected.to belong_to :learning_path }
    it { is_expected.to belong_to :course }
  end
end
