require 'test_helper'

class JewelleryCategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jewellery_categories_index_url
    assert_response :success
  end

  test "should get new" do
    get jewellery_categories_new_url
    assert_response :success
  end

  test "should get create" do
    get jewellery_categories_create_url
    assert_response :success
  end

  test "should get edit" do
    get jewellery_categories_edit_url
    assert_response :success
  end

  test "should get update" do
    get jewellery_categories_update_url
    assert_response :success
  end

end
