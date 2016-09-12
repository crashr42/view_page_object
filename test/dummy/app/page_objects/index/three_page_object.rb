module Index
  class ThreePageObject
    include RailsPo::Base

    def hello
      "Hello, #{@name}!"
    end
  end
end
