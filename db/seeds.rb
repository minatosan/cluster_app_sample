# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    #email = Faker::Internet.email
    #password = Faker::Internet.password(min_length: 10, max_length: 20)
    #User.create(email: email,password: password)
    #Article.create(title: "あいうえお",user_id: 1)

    #100.times do
     #Article.create()
    #end
    name = Faker::Name.name
    text=Faker::Esport.game
    50.times do
      Group.create(name: name,text: text)
    end

    #Article.create(lat:35.69774,lng:139.71000)
    #Article.create(lat:35.70029,lng:139.83369)
    #Article.create(lat:35.70705,lng:139.83189)
    #Article.create(lat:35.71012,lng:139.82803)
    #Article.create(lat:35.71775,lng:139.81678)
  
    CategoryName.create(name: '未登録')
    
      