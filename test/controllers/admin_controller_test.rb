require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get indexd" do
    get :indexd
    assert_response :success
  end

end
