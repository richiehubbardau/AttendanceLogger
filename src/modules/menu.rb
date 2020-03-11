
module UserMenu
  def show_menu(user)
    puts "Menu Options:\n"
    if @role == 'TEACHER'
      puts "Menu for Teachers"
      case gets.chomp.upcase
      when 'EXIT'
        puts "Will Exit"
      when 'ADDUSER'
        puts "Will add a user here"
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