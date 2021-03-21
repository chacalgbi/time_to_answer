require 'test_helper'

class ProfileBackoffice::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_backoffice_welcome_index_url
    assert_response :success
  end

end
