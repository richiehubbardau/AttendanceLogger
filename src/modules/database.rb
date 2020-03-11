require 'sequel'

def initialize_database
  File.file?('../database.db') ? (return Sequel.connect('sqlite://../database.db')) : (return create_database)
end

def create_database
  db = Sequel.connect('sqlite://../database.db')

  # Here we are creating the table for our Users

  db.create_table :users do
    primary_key :id
    Integer :student_id
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
  db[:users].insert(:name => "admin", :email => "admin", :password => "password", :role => 'TEACHER')
  db[:users].insert(:name => "student", :email => "student@email.com", :password => "password", :role => 'STUDENT', :student_id => 1)

end
def find_user(login, role=nil)
  puts login
  puts role
  if role == 'TEACHER'
    user = @db[:users].first(:email => login)
    puts "Teacher here"
  elsif role == 'STUDENT'
    puts "Student Here"
    user = @db[:users].first(:student_id => login)
  end
  return user
end
