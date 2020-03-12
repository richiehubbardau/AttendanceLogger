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
    Boolean :active
    Boolean :first_run
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
  db[:users].insert(:name => "admin", :email => "admin", :password => "password", :role => 'TEACHER', :active => true, :first_run => true)
  db[:users].insert(:name => "student", :email => "student@email.com", :password => "password", :role => 'STUDENT', :student_id => 1, :active => true, :first_run => true)

end
def find_user(login, role=nil)
  if role == 'TEACHER'
    user = @db[:users].first(:email => login)
  elsif role == 'STUDENT'
    user = @db[:users].first(:student_id => login)
  end
  return user
end

def add_user(db, name, role, student_id = nil, email = nil)
  if role == 'TEACHER'
    duplicate = find_user(email, role)
    if duplicate.nil?
      db[:users].insert(:name => name, :role => role, :email => email, :password => "teacher1234", :first_run => true, :active => true)
      return true, nil
    else
      return false, "Duplicate Email"
    end

  elsif role == 'STUDENT'
    duplicate = find_user(student_id, role)
    if duplicate.nil?
      db[:users].insert(:name => name, :role => role, :student_id => student_id, :password => "student1234", :first_run => true, :active => true)
      return true, nil
    else
      return false, "Duplicate Student ID"
    end
  else
    return false
  end
end

def change_password(role, student_id, email)
  current = nil
  if role == 'STUDENT'
    @db[:users].where(:student_id => student_id).update(:password => 'newpassword')
    current = find_user(student_id, role)
  elsif role == 'TEACHER'
    @db[:users].where(:email => email).update(:password => 'newpassword')

    puts "Finding current user"
    current = find_user(email, role)

    puts "trying to update"
    puts current
  else
    return false
  end

    # posts.where(Sequel[:stamp] < Date.today - 7).update(state: 'archived')
    # UPDATE posts SET state = 'archived' WHERE (stamp < '2010-07-07')
  puts "Hereeee"
  current.update(password: 'newpassword')
  puts current
  puts "got here"
end