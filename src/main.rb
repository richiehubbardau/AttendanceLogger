require_relative 'modules/database'
require_relative 'classes/user'
require_relative 'classes/log'
require_relative 'modules/role_check'
require 'io/console'
require_relative 'modules/loops'

db = initialize_database

class MainLoop
  include Loops
  def initialize(db)
    @db = db
    @user = nil
    @current = 'welcome'
    @error = nil
    @role = nil
  end
  def welcome_loop(error)
    p 'welcome loop'
    @role, @error = welcome(error)
    @role.nil? ? (puts @error; sleep(2)) : @current = 'login'; @error = nil
  end

  def login_loop(error)
    p 'login loop'
    @user = login(error)
    @user.nil? ? (puts @error; sleep(2)) : @current = 'password'; @error = nil
  end

  def logout_loop

  end

  def password(error=nil)
    p 'getting password'
    @confirmed = check_password(@user)
    @confirmed ? (@error = nil; @current = 'menu') : (puts @error; sleep(2))
  end

  def show_menu(role)
    puts @role
  end

  def run_loops
    loop do
      case @current
      when 'welcome'
        @error = welcome_loop(@error)
      when 'login'
        @error = login_loop(@error)
      when 'password'
        password(@error)
      when 'menu'
        show_menu(@role)
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