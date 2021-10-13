require "test_helper"

class PetsToggleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pets_toggle_index_url
    assert_response :success
  end
end
