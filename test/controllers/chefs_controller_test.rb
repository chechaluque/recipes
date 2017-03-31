require 'test_helper'

class ChefsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get chefs_show_url
    assert_response :success
  end

end
