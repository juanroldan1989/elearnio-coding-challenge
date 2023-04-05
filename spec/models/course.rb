# frozen_string_literal: true

require "rails_helper"

RSpec.describe Course, type: :model do
  subject { build(:course) }

  describe "associations" do
    it { is_expected.to have_many :talent_courses }
    it { is_expected.to have_many :talents }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :author_id }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_uniqueness_of(:title) }
  end
end
