require "test_helper"

class UserSubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_subjects_new_url
    assert_response :success
  end
end
