# Scaffold
class Site
  class << self
    def current
      new
    end
  end

  def protocol
    'http'
  end

  def method_missing(*args)
    nil
  end
end
