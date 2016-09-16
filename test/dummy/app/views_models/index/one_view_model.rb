module Index
  class OneViewModel
    include RailsViewModel::Base

    def hello
      content_tag :h1, "Hello, #{@name}!"
    end
  end
end
