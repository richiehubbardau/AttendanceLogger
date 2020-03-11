require 'sequel'

def initialize_database
  File.file?('../database.db') ? (return Sequel.connect('sqlite://../database.db')) : (return create_database)
end

def create_database
  db = Sequel.connect('sqlite://../database.db')

  # Here we are creating the table for our Users

  db.create_table :users do
    primary_key :id
    String :name
    String :role
    String :password
    String :email
  end

  # Creating Table Structure For the Attendance Log

  db.create_table :logs do
    primary_key :id
    Boolean :approved
    Boolean :overwrite
    DateTime :sign_in_dateTime
    DateTime :sign_out_dateTime
  end

  puts "Woah! Looks like you've not run this before.. lets get some information!"
  db[:users].insert(:name => "admin", :email => "admin", :password => "password")

end

def find_user(login, role=nil)
  puts login
  puts role
  user = @db[:users].first(:email => login)
  puts user
  return role.nil? ? @db[:users].first(:id => login) : @db[:users].first(:email => login)
end