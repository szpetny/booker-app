namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Szmatalson",
                 surname: "Dupalson",
                 email: "example@dupa.org",
                 password: "chujek",
                 password_confirmation: "chujek",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      surname = "Dupalson#{n+1}"
      email = "example-#{n+1}@dupa.org"
      password  = "password"
      User.create!(name: name,
                   surname: surname,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end