module Demo
  module Index
    class OneViewModel
      include RailsViewModel::Base

      def hello
        "I live in #{@city}!"
      end
    end
  end
end
