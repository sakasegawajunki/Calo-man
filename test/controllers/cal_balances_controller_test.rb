require 'test_helper'

class CalBalancesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get cal_balances_show_url
    assert_response :success
  end
end
