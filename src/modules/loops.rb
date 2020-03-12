require_relative 'database'
require_relative 'helpers'

module Loops
  def welcome(error)
    Screen.clear
    puts "Welcome to your Attendance Logger"
    puts "Are you a student or teacher?"
    error.nil? ? nil : (puts error)
    case gets.chomp.upcase

    when 'TEACHER'
      return 'TEACHER'
    when 'STUDENT'
      return 'STUDENT'
    else
      @error = 'You are required to input student or teacher only!'
      return nil, @error
    end
  end

  def login(error)
    Screen.clear
    puts "You have activated #{@role} mode!"
    puts "Please input your #{@role == 'TEACHER' ? "Email Address" : "Student ID"}"
    error.nil? ? nil : (puts error)
    login = gets.chomp
    #@user = @role == 'TEACHER' ? Teacher.new(login)
    if @role == 'TEACHER'
      @user = Teacher.new(@db, login)
    elsif @role == 'STUDENT'
      @user = Student.new(@db, login)
    else
      raise "Role should be Student or Teacher?!"
    end
    @user.nil? ? @error = "Unable to locate User" : @error = nil
    return @user
  end

  def check_password(error)
    Screen.clear
    puts "Welcome #{@user.name}: Please enter your password"
    pw = STDIN.noecho(&:gets).chomp
    pw_check = @user.check_password(pw)
    if @user.first_run
      puts "You need to change password"
      change_password(@role, @student_id, @email)
      puts "Changing Password"
    end
    pw_check ? @current = 'menu' : @error = "Incorrect Password Supplied"

    return pw_check, @error
  end
end