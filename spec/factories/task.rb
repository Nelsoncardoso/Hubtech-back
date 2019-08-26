FactoryBot.define do
    factory :task do
        name    { FFaker::Movie.title }
        description { FFaker::Lorem.sentence }
        end_time { 10.days.from_now }
        user     { FactoryBot.create(:user) }
    end
end
