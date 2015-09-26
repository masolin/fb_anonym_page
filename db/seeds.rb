# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
tag_list = []
3.times { tag_list << Faker::Commerce.department(1) }

100.times do |number|
  fake_content = Faker::Lorem.paragraphs(3, true).join("\n")
  fake_tag = tag_list.sample
  fake_published = false
  Post.create!(
    content: fake_content,
    category_list: fake_tag,
    published: fake_published)
end

User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
