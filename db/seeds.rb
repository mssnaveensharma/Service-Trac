# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create({
          :email=>'corey@selectcommusa.com',
          :password=>'Admin123#',
          :FirstName=>'Corey',
          :LastName=>'Mayerlen',
          :Role=>"admin"
        });
        
User.create({
          :email=>'mss.naveensharma@gmail.com',
          :password=>'Admin123#',
          :FirstName=>'Naveen',
          :LastName=>'Sharma',
          :Role=>"admin"
        });