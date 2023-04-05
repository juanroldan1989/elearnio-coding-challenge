# == Schema Information
#
# Table name: talents
#
# t.string "first_name", null: false
# t.string "last_name", null: false

FactoryBot.define do
  factory :talent do
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
  end
end
