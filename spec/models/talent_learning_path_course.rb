# frozen_string_literal: true

require "rails_helper"

RSpec.describe TalentLearningPathCourse, type: :model do
  subject { build(:talent_learning_path_course) }

  describe "associations" do
    it { is_expected.to belong_to :talent }
    it { is_expected.to belong_to :learning_path }
    it { is_expected.to belong_to :course }
  end
end
