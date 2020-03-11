require_relative 'database'

def check_role(role)
  loop do
    if role == 'TEACHER'
      puts "Please enter your email address"
      email = gets.chomp.upcase
      user = Teacher.new(email)
      count = 0
      while user.nil?
        puts "Email address not found\Please enter your correct email address"
        count += 1
        if count >= 5
          puts "You have entered the wrong email too many times.\nClosing program now!"
          break
        end
        email = gets.chomp.upcase
        user = Teacher.new(email)
      end
    elsif role == 'STUDENT'
      puts "Please enter your student ID"
      id = gets.chomp
      while id.is_a? !Integer
        puts "Please Enter Your Student ID as NUMBERS only"
        id = gets.chomp
      end
      user = Student.new(id)
    else
      puts "Please enter student or teacher !"
    end
  end
end