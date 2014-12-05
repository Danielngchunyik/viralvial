FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"

    trait :without_password do
      password nil
      password_confirmation nil
    end

    trait :admin do
      role 'admin'
    end
  end
end
