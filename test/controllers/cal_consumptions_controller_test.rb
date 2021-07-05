require 'test_helper'

class CalConsumptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cal_consumptions_new_url
    assert_response :success
  end

  test "should get edit" do
    get cal_consumptions_edit_url
    assert_response :success
  end

end
