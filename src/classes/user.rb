require 'sequel'
require_relative '../modules/database'

class User
  def initalize
    @id = ""
    @email = ""
    @name = ""
    @password = ""
    @role = ""
  end
  def populate_user(id, role)
    @user = find_user(email, role)
    @id = @user[:id]
    @name = @user[:name]
    @password = @user[:password]
    @role = role
  end
end

class Teacher < User
  def initialize(email)
    populate_user(email)
  end
end

class Student < User
  def initalize(id)
    populate_user(id)
  end
end