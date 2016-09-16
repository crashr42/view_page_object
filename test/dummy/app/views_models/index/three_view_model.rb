module Index
  class ThreeViewModel
    include RailsViewModel::Base

    def hello
      "Hello, #{@name}!"
    end
  end
end
