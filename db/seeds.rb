User.create!(code: "201488",
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar")

50.times do |n|
  code = Faker::Code.npi
  name = Faker::Name.name
  email = "example#{n+1}@mail.org"
  password = "123456"
  User.create!(
    code: code,
    name: name,
    email: email,
    password: password,
    password_confirmation: password)

end
