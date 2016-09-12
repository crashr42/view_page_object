module Index
  class OnePageObject
    include RailsPo::Base

    def hello
      content_tag :h1, "Hello, #{@name}!"
    end
  end
end
