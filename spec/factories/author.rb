# == Schema Information
#
# Table name: authors
#
# t.string "first_name", null: false
# t.string "last_name", null: false
# t.integer "talent_id"

FactoryBot.define do
  factory :author do
    first_name { Faker::Name.unique.name }
    last_name { Faker::Name.unique.name }
    talent_id { nil }
  end
end
