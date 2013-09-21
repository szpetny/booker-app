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
  
  factory :author do
    name  "Chlepton"
    surname "Grubson"
  end
  
  factory :book do
    isbn "83-07-0234204"
    title "Mistrz i Malgorzata"
    author 
    language "polski"
    description "Mistrz i Malgorzata"
    quantity 1
    place "kredens u Gosi"
    pages 476
  end
end