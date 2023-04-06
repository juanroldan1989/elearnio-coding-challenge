# frozen_string_literal: true

require "rails_helper"

RSpec.describe Talent, type: :model do
  subject { build(:talent) }

  describe "associations" do
    it { is_expected.to have_many :talent_courses }
    it { is_expected.to have_many(:courses).through(:talent_courses) }
    it { is_expected.to have_many :talent_learning_path_courses }
    it { is_expected.to have_many(:learning_paths).through(:talent_learning_path_courses) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    # it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name).case_insensitive }
  end
end
