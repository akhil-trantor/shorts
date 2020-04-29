FactoryGirl.define do
  factory :link do |f|
    f.url { Faker::Internet.url }
  end

  factory :invalid_link, parent: :link do |f|
    f.url nil
  end
end
