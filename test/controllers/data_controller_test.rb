require 'test_helper'

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get data_show_url
    assert_response :success
  end
end
