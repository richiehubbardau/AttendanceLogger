require_relative 'database'
require_relative 'helpers'


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
    return nil
  end
end