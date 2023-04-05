# == Schema Information
#
# Table name: courses
#
# t.string "title", null: false
# t.text "description"
# t.integer "author_id", null: false

FactoryBot.define do
  factory :course do
    title { Faker::Name.unique.name }
    description { Faker::Markdown.emphasis }
    author_id { 99999 }
  end
end
