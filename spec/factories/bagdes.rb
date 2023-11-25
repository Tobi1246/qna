FactoryBot.define do
  factory :badge do
    name { "Best answer in question:" }
    img { "https://dj.ru/user_music/covers/31/668331_f5862674505cfcdb58a1abf53165f672.jpg" }
    conditions { "best_answer" }
  end
end
