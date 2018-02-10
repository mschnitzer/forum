FactoryBot.define do
  factory :board do
    sequence(:name) { |n| "board_#{n}" }
    description Faker::Lorem.sentence
    parent_id nil

    factory :board_category do
      category true
    end
  end
end
