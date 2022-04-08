require "test_helper"

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get _search" do
    get searches__search_url
    assert_response :success
  end
end
