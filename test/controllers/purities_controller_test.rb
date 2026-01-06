require 'test_helper'

class PuritiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purities_index_url
    assert_response :success
  end

  test "should get new" do
    get purities_new_url
    assert_response :success
  end

  test "should get create" do
    get purities_create_url
    assert_response :success
  end

  test "should get edit" do
    get purities_edit_url
    assert_response :success
  end

  test "should get update" do
    get purities_update_url
    assert_response :success
  end

end
