module Index
  class OnePageObject
    include ViewPageObject::Base

    def hello
      content_tag :h1, "Hello, #{@name}!"
    end
  end
end
