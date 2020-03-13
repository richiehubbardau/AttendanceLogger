require_relative 'helpers'
require_relative 'database'
require 'whirly'
require 'terminal-table'

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

              Whirly.start spinner: 'dots' do
                Whirly.status = "Please enter digits only!"
                sleep 3
              end
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

      when 'DELUSER'
        puts "Are you deleting a Teacher or Student?"
        u_id = ""
        loop do
          role = gets.chomp.upcase
          puts role
          if role == 'TEACHER' or role == 'STUDENT'
            puts "Please enter #{role == 'TEACHER' ? "teachers email" : "students ID"}"
            u_id = gets.chomp
            break
          elsif role == 'EXIT'
            break
          else
            puts "Please enter Teacher or Student - or type EXIT to go back to menu"
          end
        end
        if role != 'EXIT'
          puts role
          if role == 'STUDENT'
            user = find_user(role, u_id.to_i)
          else
            user = find_user(role, u_id)
          end

          puts user
          if !user.nil?
            make_inactive(user)

            puts "#{role} has been made inactive - to delete type DELETE else return anything to go back to menu"

            delete = gets.chomp.upcase
            if delete == 'DELETE'
              delete_user(user)
              Whirly.start spinner: 'dots' do
                Whirly.status = sign_out(@user.student_id, Date.today)
                sleep 3
              end
            end
          end

        end
      when 'STATISTICS'
        puts "Enter student ID which you wish to view login stats"
        s_id = gets.chomp
        user = find_user(s_id.to_i, 'STUDENT')
        if !user.nil?
          show_statistics(user[:student_id])
          puts "Press enter to go back to menu"
          gets.chomp
        else
          Whirly.start spinner: 'dots' do
            Whirly.status = "Unable to locate user - please check student ID is correct"
            sleep 3
          end
        end
      end
    elsif @role == 'STUDENT'
      puts "Student Menu!"
      puts "SIGNIN - To sign in for the day"
      puts "SIGNOUT - To Sign out for the day"
      puts "STATISTICS - To show user statistics"
      puts "LOGOUT - To Return to Login Window"
      puts "EXIT - To Close Program"
      case gets.chomp.upcase

      when 'SIGNIN'
        Whirly.start spinner: 'dots' do
          Whirly.status = sign_in(@user.student_id, Date.today)
          sleep 3
        end

      when "SIGNOUT"
        Whirly.start spinner: 'dots' do
          Whirly.status = sign_out(@user.student_id, Date.today)
          sleep 3
        end
      when "STATISTICS"
        show_statistics(@user.student_id)
        puts "Press enter to go back to menu"
        gets.chomp

      when 'LOGOUT'
        @current = 'welcome'
        return
      when 'EXIT'
        @current = 'EXIT'
        return
      end
    end


  end
  def show_statistics(student_id)
    stats = get_logs(student_id)
    rows = []
    rows << ['Date', 'Sign-In Time', 'Sign-Out Time']

    stats.each { |s| rows << [s[:date], s[:sign_in], s[:sign_out]] }
    table = Terminal::Table.new :rows => rows
    puts table
      #stats.each { |s| puts "Date: #{s[:date]} Sign-In: #{s[:sign_in]} Sign-Out: #{s[:sign_out]}" }

  end
end