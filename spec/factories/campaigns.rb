FactoryGirl.define do
  factory :campaign do
    start_date Date.today
    end_date Date.tomorrow
    title 'MyString'
    description 'MyString'
    topics_attributes [{description: 'Topic description', title: 'Topic title'}]

    trait :without_topic do
      topics_attributes []
    end
  end
end
