# user, students
User.create!(
  code: "2014201418",
  name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  image: open("app/assets/images/femaleava.jpg")
)

100.times do |n|
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

# 50: 1-50 subject hoc_phan
20.times do |n|
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

  # add classroom to subject
  num = 2 + rand(4)
  num.times do |nroom|
    code = Faker::Code.nric
    capacity = 15 + rand(146)
    subject_id = n + 1
    Room.create!(
      code: code,
      capacity: capacity,
      subject_id: subject_id)
  end
end

# add (register) subjects to student's subject list
# 50.times do |n|
#   if (n > 0)
#     user_id = n
#     arr = []
#     rand(10).times do |m|
#       subject_id = 1 + rand(50)
#       if ( !(arr.include? subject_id) )
#         arr << subject_id
#         UserSubject.create!(
#           user_id: user_id,
#           subject_id: subject_id
#         )
#       end
#     end
#   end
# end

# Added in create subjects
# Create Classrooms
# 200.times do |n|
#   code = Faker::Code.nric
#   capacity = 15 + rand(146)
#   subject_id = 1 + rand(50)
#   Room.create!(
#     code: code,
#     capacity: capacity,
#     subject_id: subject_id)
# end

# add class list to students
101.times do |n|
  user_id = n+1
  arr_subject = []
  arr_room = []
  num = 5 + rand(6)
  num.times do |k|
    subject_id = 1 + rand(20)
    subject = Subject.find_by id: subject_id
    rooms = subject.rooms
    unless (arr_subject.include? subject_id)
      arr_subject << subject_id
      UserSubject.create!(
        user_id: user_id,
        subject_id: subject_id
      )

      room_id = rooms.offset(rand(rooms.count)).first.id
      arr_room << room_id
      RoomUser.create!(
        user_id: user_id,
        room_id: room_id
      )
    end
  end
end
