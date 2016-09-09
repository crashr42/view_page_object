module Demo
  module Index
    class OnePageObject
      include ViewPageObject::Base

      def hello
        "I live in #{@city}!"
      end
    end
  end
end
