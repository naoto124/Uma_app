require 'test_helper'

class UmaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get uma_index_url
    assert_response :success
  end

end
