include RandomData

FactoryGirl.define do
  factory :comment do
    body RandomData.random_paragraph
    post
  end
end
