module Demo
  module Index
    class OnePageObject
      include RailsPo::Base

      def hello
        "I live in #{@city}!"
      end
    end
  end
end
