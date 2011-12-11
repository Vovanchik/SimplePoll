# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

role_super_user = Role.create(:name => 'super_user', :description => 'This is super user')

admin_user = User.create(:id =>1,
            :nick=> 'webmaster',
            :password => '01Ericpol!',
            :password_confirmation => '01Ericpol!',
            :email => 'vovanchik@gmail.com',
            :role => role_super_user)