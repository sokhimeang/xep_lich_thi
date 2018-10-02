User.create!(
  code: "2014201418",
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  image: open("app/assets/images/femaleava.jpg")
)

50.times do |n|
  code = Faker::Code.npi
  name = Faker::Name.name
  email = "example#{n+1}@mail.org"
  password = "123456"
  image = "maleava.jpeg"
  User.create!(
    code: code,
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    image: open("app/assets/images/maleava.jpeg")
  )
end

Subject.create!(code: "ET1010",
  name: "Examples",
  exam_during: 60)

50.times do |n|
  if n < 10
    code = "ET200#{n}"
  else
    code = "ET20#{n}"
  end
  name = Faker::Name.name
  exam_during = 45
  Subject.create!(
    code: code,
    name: name,
    exam_during: exam_during)
end

50.times do |n|
  if (n > 0)
    user_id = n
    arr = []
    rand(10).times do |m|
      subject_id = rand(50)
      if (!(arr.include? subject_id)) && (subject_id >= 1)
        arr << subject_id
        UserSubject.create!(
          user_id: user_id,
          subject_id: subject_id
        )
      end
    end
  end
end
