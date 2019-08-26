FactoryBot.define do
    factory :user do
        email {  FFaker::Internet.unique.email}
        name { FFaker::NameBR.unique.name }
        password {  "secret123" }
        password_confirmation {  "secret123" }
    end
end
