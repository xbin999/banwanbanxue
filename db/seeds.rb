# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Item.create!([
  {title: "跑步", description: nil},
  {title: "阅读", description: nil},
  {title: "电影", description: nil},
  {title: "平板", description: nil},
  {title: "开发", description: nil},
  {title: "公众号", description: nil}
])
