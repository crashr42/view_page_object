require File.expand_path('../test_helper', __FILE__)

class TestPageObject
  include ViewPageObject::Base

  def hello
    "Hello, #{@name}!"
  end
end

class ViewPageObject::Test < ActionDispatch::IntegrationTest
  test 'one action should have page object' do
    get index_one_url

    assert_not_nil @controller, :page
    assert_kind_of ViewPageObject::Base, @controller.instance_variable_get(:@page)

    assert_match '<h1>Hello, Mark!</h1>', @response.body
  end

  test 'two action should not have page object' do
    get index_two_url

    refute @controller.instance_variable_defined?(:@page)
  end

  test 'support namespaced controller' do
    get demo_index_one_url

    assert_not_nil @controller, :page
    assert_kind_of ViewPageObject::Base, @controller.instance_variable_get(:@page)

    assert_match '<h1>I live in Boston!</h1>', @response.body
  end

  test 'test page object should respond hello' do
    page = TestPageObject.new(name: 'Henry')

    assert_equal 'Hello, Henry!', page.hello

    page = TestPageObject.new({'name' => 'Henry'})

    assert_equal 'Hello, Henry!', page.hello
  end
end
