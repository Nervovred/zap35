#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Init first category

#Category.create(:title => 'Запчасти для автомобиля', :partial => '_car_parts')

PartCategory.find_or_create_by_title('УАЗ')
PartCategory.find_or_create_by_title('ВАЗ')