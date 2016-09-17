class IndexController < ApplicationController
  def one
    @name = 'Mark'
  end

  def two
  end

  def three
    @name = 'Mark'

    render plain: vm.hello
  end
end
