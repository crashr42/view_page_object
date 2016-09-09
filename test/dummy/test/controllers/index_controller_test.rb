require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get one" do
    get index_one_url
    assert_response :success
  end

  test "should get two" do
    get index_two_url
    assert_response :success
  end

end
