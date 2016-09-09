module Index
  class OnePageObject
    include ViewPageObject::Base

    def hello
      "Hello, #{@name}!"
    end
  end
end
