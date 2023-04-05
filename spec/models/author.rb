# frozen_string_literal: true

require "rails_helper"

RSpec.describe Author, type: :model do
  subject { build(:author) }

  describe "associations" do
    it { is_expected.to have_many :courses }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    # it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name).case_insensitive }
  end
end
