require 'test_helper'

class CalIngestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cal_ingestions_new_url
    assert_response :success
  end

  test "should get edit" do
    get cal_ingestions_edit_url
    assert_response :success
  end

end
