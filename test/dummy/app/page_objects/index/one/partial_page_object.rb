module Index
  module One
    class PartialPageObject
      include RailsPo::Base

      def hello
        'hello from partial'
      end
    end
  end
end
