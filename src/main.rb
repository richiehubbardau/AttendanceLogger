require_relative 'modules/database.rb'
require_relative 'classes/user.rb'
require_relative 'classes/log.rb'
require_relative 'modules/role_check.rb'

require_relative 'modules/loops.rb'

db = initialize_database

class MainLoop

  def initialize
    @user = nil
    @current = 'welcome'
    @error = nil
  end
  def welcome_loop(error=nil)
    p 'welcome loop'
    @role = welcome(error)
    @role.nil? ? (puts @error) : @current = 'login'
  end

  def login_loop

  end

  def logout_loop

  end

  def run_loops
    loop do
      case @current
      when 'welcome'
        welcome_loop(@error)
      when 'login'
        login_loop
        break
      else
        p 'something went wrong'
        break
      end
      p @current
    end
  end
end
MainLoop.new().run_loops