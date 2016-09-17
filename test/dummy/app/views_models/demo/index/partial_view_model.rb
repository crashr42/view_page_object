module Demo
  module Index
    class PartialViewModel
      include RailsViewModel::Base
      
      def hello
        content_tag :h1, "I'am view `partial` from controller `demo/index!`"
      end
    end
  end
end
