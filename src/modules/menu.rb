require_relative 'helpers'
require_relative 'database'
require 'whirly'

module UserMenu
  def show_menu(user)
    Screen.clear
    puts "Menu Options:\n"
    if @role == 'TEACHER'
      puts "Teachers Menu!"
      puts "ADDUSER - To add a user"
      puts "DELUSER - To remove a user"
      puts "STATISTICS - To show user statistics"
      puts "LOGOUT - To Return to Login Window"
      puts "EXIT - To Close Program"
      case gets.chomp.upcase
      when 'LOGOUT'
        @current = 'welcome'
        return
      when 'EXIT'
        @current = 'EXIT'
        return
      when 'ADDUSER'
        puts "Are you adding a student or teacher?"
        r = false
        while !r
          role = gets.chomp.upcase
          if role == 'STUDENT' || role == 'TEACHER'
            r = true
          elsif role == 'MENU'
            return
          else
            puts "Please type Student or Teacher or Menu to return"
          end
        end
        puts "Please enter #{role} name"
        name = gets.chomp
        email = ""
        student_id = ""
        if role == 'TEACHER'
          puts "Please enter teachers email address"
          e = false
          while !e
            email = gets.chomp
            if email =~ URI::MailTo::EMAIL_REGEXP
              e = true
            else
              puts "Please enter a valid email address"
            end
          end
          adduser, error = add_user(@db, name, role, student_id, email)
          if adduser
            Whirly.start spinner: 'dots' do
              Whirly.status = "Please Wait - Creating new User Name: #{name} Email: #{email} Password: teacher1234 Role: #{role}"
              sleep 5
              Whirly.status = "User Created Successfully"
              sleep 2
            end
          else
            Whirly.start spinner: 'dots' do
              Whirly.status = "Unable to create User - Error: #{error}"
              sleep 3
            end
          end
        elsif role == 'STUDENT'
          puts "Please enter student ID"
          i = false
          while !i
            student_id = gets.chomp.to_i
            if student_id.is_a? Integer
              i = true
            else
              puts "Please enter digits Only!"
            end
          end
          adduser, error = add_user(@db, name, role, student_id, email)
          if adduser
            Whirly.start spinner: 'dots' do
              Whirly.status = "Please Wait - Creating new User Name: #{name} Email: #{email} Password: student1234 Role: #{role}"
              sleep 5
              Whirly.status = "User Created Successfully"
              sleep 2
            end
          else
            Whirly.start spinner: 'dots' do
              Whirly.status = "Unable to create User - Error: #{error}"
              sleep 3
            end
          end
        end

      when 'REMOVEUSER'
        puts "Will remove a user here"
      when 'STATISTICS'
        puts "Will show some statistics here"
      end
    elsif @role == 'STUDENT'
      puts "Menu For Students"
      case gets.chomp.upcase
      when 'EXIT'
        puts "Gonna Exit Like its hot"
      when 'SIGNIN'
        puts "Signing You In"
      when "SIGNOUT"
        puts "signing you out"
      when "HELP"
        puts "Do some kinda help menu"
      end
    end

  end

end