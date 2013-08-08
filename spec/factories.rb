FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Szmatalson #{n}" }
    sequence(:surname)  { |n| "Dupalson #{n}" }
    sequence(:email) { |n| "szmatalson_#{n}@example.com"}
    password "jebjeb"
    password_confirmation "jebjeb"
    
    factory :admin do
      admin true
    end
  end
end