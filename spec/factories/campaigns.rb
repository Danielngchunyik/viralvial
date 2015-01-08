FactoryGirl.define do
  factory :campaign do
    private false
    start_date Date.today
    deadline Date.today
    title "MyString"
    description "MyString"
  end
end
