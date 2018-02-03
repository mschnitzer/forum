FactoryBot.define do
  factory :user do
    sequence :username { |n| "user_#{n}" }
    email Faker::Internet.email
    password "test"

    factory :admin_user do
      after(:create) do |admin_user|
        admin_user.user_to_groups.create(group: Group.find_by(name: 'Administrators'))
      end
    end
  end
end
