# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: '逆瀬川純輝',
  name_kana: 'サカセガワジュンキ',
  sex: "0".to_i,
  age: '31',
  height: "168",
  weight: "58",
  introduction: "鹿児島県出身です。走ることが好きです。",
  email: 'sakasegawa@mail.com',
  password: "ssssss",
  profile_image: File.open("./app/assets/images/foto-sushi-6anudmpILw4-unsplash.jpg"),
  )
  
User.create(
  name: '伊藤麻衣',
  name_kana: 'イトウマイ',
  sex: "1".to_i,
  age: '25',
  height: "158",
  weight: "48.1",
  introduction: "毎日一時間ジムで走ってます。趣味は料理です。",
  email: "ito@gmail.com",
  password: "iiiiii",
  profile_image: File.open("./app/assets/images/sigmund-jzz_3jWMzHA-unsplash.jpg"),
  )
  
  User.create(
  name: '鈴木太郎',
  name_kana: 'スズキタロウ',
  sex: "0".to_i,
  age: '27',
  height: "178.5",
  weight: "75",
  introduction: "体幹トレーニングに力を入れてます。趣味は野球です。",
  email: "suzuki@gmail.com",
  password: "ssssss",
  profile_image: File.open("./app/assets/images/joseph-gonzalez-iFgRcqHznqg-unsplash.jpg"),
  )
  
  User.create(
  name: '田中京子',
  name_kana: 'タナカキョウコ',
  sex: "1".to_i,
  age: '32',
  height: "148",
  weight: "45",
  introduction: "2児の母親です。趣味はお絵描きです。",
  email: "tanaka@gmail.com",
  password: "tttttt",
  profile_image: File.open("./app/assets/images/woman-1853939_640.jpg"),
  )
  
  User.create(
  name: '久保健太',
  name_kana: 'クボケンタ',
  sex: "0".to_i,
  age: '45',
  height: "160",
  weight: "56",
  introduction: "趣味は旅行、写真です。",
  email: "kubo@gmail.com",
  password: "kkkkkk",
  profile_image: File.open("./app/assets/images/man-945438_640.jpg"),
  )
  
  User.create(
  name: '令和道子',
  name_kana: 'レイワミチコ',
  sex: "1".to_i,
  age: '50',
  height: "178",
  weight: "65",
  introduction: "カフェ巡りが趣味です。",
  email: "reiwa@gmail.com",
  password: "rrrrrr",
  profile_image: File.open("./app/assets/images/young-woman-1149643_640.jpg"),
  )