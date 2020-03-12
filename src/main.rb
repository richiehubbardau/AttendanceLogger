require_relative 'modules/database'
require_relative 'classes/user'
require_relative 'classes/log'
require 'io/console'
require_relative 'modules/loops'
require_relative 'modules/menu'

db = initialize_database

class MainLoop
  include Loops
  include UserMenu
  def initialize(db)
    @db = db
    @user = nil
    @current = 'welcome'
    @error = nil
    @role = nil
  end
  def welcome_loop(error)
    @role, @error = welcome(error)
    @role.nil? ? (puts @error; sleep(2)) : @current = 'login'; @error = nil
  end

  def login_loop(error)
    @user = login(error)
    p @user
    @user.name.nil? ? (puts @error; sleep(2)) : @current = 'password'; @error = nil
  end

  def logout_loop

  end

  def password(error=nil)
    @confirmed, @error = check_password(@user)
    @confirmed ? (@error = nil; @current = 'menu') : (puts @error; sleep(2))
  end

  def run_loops
    pw_count = 0
    loop do
      case @current
      when 'welcome'
        @error = welcome_loop(@error)
      when 'login'
        @error = login_loop(@error)
      when 'password'
        pw_count += 1
        password(@error)
        if pw_count > 5
          @current = 'exit'
          puts "Guessed PW too many times. Closing"
        end
      when 'menu'
        show_menu(@role)
      when 'exit'
        puts "Goodbye."
        break
      else
        p 'something went wrong'
        break
      end
      p @current
    end
  end
end

MainLoop.new(db).run_loops