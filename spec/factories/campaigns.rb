FactoryGirl.define do
  factory :campaign do
    start_date Date.today
    end_date 1.day.from_now
    title 'MyString'
    description 'MyString'
  end
end
