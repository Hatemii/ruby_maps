require "test_helper"

class FoundPetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get found_pets_index_url
    assert_response :success
  end
end
