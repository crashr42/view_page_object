module Index
  class PartialViewModel
    include RailsViewModel::Base

    def hello
      'hello from partial'
    end
  end
end
