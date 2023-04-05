# == Schema Information
#
# Table name: learning_paths
#
# t.string "title", null: false
# t.text "description"

FactoryBot.define do
  factory :learning_path do
    title { Faker::Name.unique.name }
    description { Faker::Markdown.emphasis }
  end
end
