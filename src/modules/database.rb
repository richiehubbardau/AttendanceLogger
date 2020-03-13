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
  Whirly.start spinner: 'dots' do
    Whirly.status = "Looks like you haven't run this before! Currently creating you a database .. hold on!"
    sleep 3
    Whirly.status = "Your default login for teacher is admin:password - please change on first use"
    sleep 5
  end
  db[:users].insert(:name => "admin", :email => "admin", :password => "password", :role => 'TEACHER', :active => true, :first_run => true)
  db[:users].insert(:name => "student", :email => "student@email.com", :password => "password", :role => 'STUDENT', :student_id => 1, :active => true, :first_run => true)
  db[:logs].insert(:student_id => 1, :date => Date.today - 5, :sign_in => DateTime.now - 5.7, :sign_out => DateTime.now - 5)
  db[:logs].insert(:student_id => 1, :date => Date.today - 4, :sign_in => DateTime.now - 4.7, :sign_out => DateTime.now - 4)
  db[:logs].insert(:student_id => 1, :date => Date.today - 3, :sign_in => DateTime.now - 3.7, :sign_out => DateTime.now - 3)
  db[:logs].insert(:student_id => 1, :date => Date.today - 2, :sign_in => DateTime.now - 2.7, :sign_out => DateTime.now - 2)
  db[:logs].insert(:student_id => 1, :date => Date.today - 1, :sign_in => DateTime.now - 1.7, :sign_out => DateTime.now - 1)
  db[:logs].insert(:student_id => 1, :date => Date.today, :sign_in => DateTime.now - 0.7, :sign_out => DateTime.now)
  Whirly.start spinner: 'dots' do
    Whirly.status = "Creating Sample Data for Student_ID #1"
    sleep 3
  end
  return db
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

def get_logs(user)
  logs = @db[:logs].where(:student_id => user)
  return logs
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