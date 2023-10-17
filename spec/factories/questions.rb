FactoryBot.define do
  factory :question do
    title { "MyString" }
    body { "MyBody" }

    trait :invalid do
      title { nil  }
    end
  end
end
