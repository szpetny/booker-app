FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Karol #{n}" }
    sequence(:surname)  { |n| "Idiota #{n}" }
    sequence(:email) { |n| "szmata#{n}@example.com"}
    password "siersciuch"
    password_confirmation "siersciuch"
    
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
    title "Leszcz i Malgorzata"
    author 
    language "ruslanski"
    description "nudny opis po rumunsku"
    quantity 1
    place "srodek jamnika"
    release_date "1986-04-26"
    pages 476
  end
  
  factory :book_category do
    category_name "Skarpety Romana"
  end
end