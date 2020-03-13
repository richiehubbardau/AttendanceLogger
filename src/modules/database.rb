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
    DateTime :sign_in
    DateTime :sign_out
    String :date
    Integer :student_id
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
    puts "Finding student"
    puts user
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

def change_password(role, student_id, email, newpwd)
  current = nil
  if role == 'STUDENT'
    current = find_user(student_id, role)
    @db[:users].where(:id => current[:id]).update(:password => newpwd, :first_run => false)
  elsif role == 'TEACHER'
    current = find_user(email, role)
    @db[:users].where(:id => current[:id]).update(:password => newpwd, :first_run => false)
  else
    return false
  end
end

def make_inactive(user)
  @db[:users].where(:id => user[:id]).update(:active => false)
end

def delete_user(user)
  @db[:users].where(:id => user[:id]).delete
end

def find_log(user, date)
  puts date
  log = @db[:logs].first(:student_id => user, :date => date)
  return log
end

def sign_in(user, date)
  if find_log(user, date).nil?
    @db[:logs].insert(:student_id => user, :date => date, :sign_in => DateTime.now)
    return "Successfully Signed In"
  else
    return "User Already Signed In for the day"
  end
end

def sign_out(user, date)
  log = find_log(user,date)
  if log.nil?
    return "User hasn't signed in for the day"
  else
    @db[:logs].where(:student_id => user, :date => date).update(:sign_out => DateTime.now)
    return "Signed User Out At #{DateTime.now}"
  end
end