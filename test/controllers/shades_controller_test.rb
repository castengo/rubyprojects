require 'test_helper'

class ShadesControllerTest < ActionController::TestCase
  setup do
    @shade = shades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shade" do
    assert_difference('Shade.count') do
      post :create, shade: { color_id: @shade.color_id, finish: @shade.finish, name: @shade.name, product_id: @shade.product_id }
    end

    assert_redirected_to shade_path(assigns(:shade))
  end

  test "should show shade" do
    get :show, id: @shade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shade
    assert_response :success
  end

  test "should update shade" do
    patch :update, id: @shade, shade: { color_id: @shade.color_id, finish: @shade.finish, name: @shade.name, product_id: @shade.product_id }
    assert_redirected_to shade_path(assigns(:shade))
  end

  test "should destroy shade" do
    assert_difference('Shade.count', -1) do
      delete :destroy, id: @shade
    end

    assert_redirected_to shades_path
  end
end
