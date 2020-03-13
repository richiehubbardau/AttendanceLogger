require 'sequel'
require_relative '../modules/database'

class User
  attr_reader :name, :role, :student_id, :email, :first_run, :active
  def initalize(db)
    @db = db
    @student_id = ""
    @email = ""
    @name = ""
    @password = ""
    @role = ""
    @student_id = ""
  end
  def populate_user(login, role)
    @user = find_user(login, role)
    if @user.nil? == false
      @id = @user[:id]
      @name = @user[:name]
      @password = @user[:password]
      @role = role
      @student_id = @user[:student_id]
      @email = @user[:email]
      @first_run = @user[:first_run]
      @active = @user[:active]
    else
      clear
      return self
    end
    return self
  end
  def clear
    @user = nil
    @id = nil
    @name = nil
    @password = nil
    @role = nil
    @student_id = nil
    @first_run = nil
    @active = nil
  end

  def check_password(pw)
    return pw == @password
  end
end

class Teacher < User
  def initialize(db, login)
    @db = db
    @role = 'TEACHER'
    user = populate_user(login, @role)
    if user.role != @role
      puts "Student Trying to Access Teacher Commands! Authorities have been notified!"
      user.clear
    end
    return user
  end
end

class Student < User
  def initialize(db, login)
    @db = db
    @role = 'STUDENT'
    user = populate_user(login, @role)
    if user.role != @role
      puts "Teacher Trying to Access Student Commands! Authorities have been notified!"
      user.clear
    end
    return user
  end
end