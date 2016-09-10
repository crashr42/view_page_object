module Index
  class ThreePageObject
    include ViewPageObject::Base

    def hello
      "Hello, #{@name}!"
    end
  end
end
