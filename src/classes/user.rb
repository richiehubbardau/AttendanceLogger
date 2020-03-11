require 'sequel'
require_relative '../modules/database'

class User
  attr_reader :name, :role
  def initalize(db)
    @db = db
    @id = ""
    @email = ""
    @name = ""
    @password = ""
    @role = ""
  end
  def populate_user(login, role)
    @user = find_user(login, role)
    p @user
    p 2
    @id = @user[:id]
    @name = @user[:name]
    @password = @user[:password]
    @role = role

    p @password
  end

  def check_password(pw)
    return pw == @password
  end
end

class Teacher < User
  def initialize(db, login)
    @db = db
    @role = 'TEACHER'
    populate_user(login, @role)
  end
end

class Student < User
  def initialize(db, login)
    @db = db
    @role = 'STUDENT'
    populate_user(login, @role)
  end
end