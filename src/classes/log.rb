require_relative '../modules/database'

class Logger

  def initialize(user)
    @User = user
    @in = ""
    @out = ""
  end

  def save
    save_log(self)
  end
end