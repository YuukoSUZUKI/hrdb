require 'test_helper'

class TarentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tarent = tarents(:one)
  end

  test "should get index" do
    get tarents_url
    assert_response :success
  end

  test "should get new" do
    get new_tarent_url
    assert_response :success
  end

  test "should create tarent" do
    assert_difference('Tarent.count') do
      post tarents_url, params: { tarent: { learning_level: @tarent.learning_level, skill_id: @tarent.skill_id, user_id: @tarent.user_id } }
    end

    assert_redirected_to tarent_url(Tarent.last)
  end

  test "should show tarent" do
    get tarent_url(@tarent)
    assert_response :success
  end

  test "should get edit" do
    get edit_tarent_url(@tarent)
    assert_response :success
  end

  test "should update tarent" do
    patch tarent_url(@tarent), params: { tarent: { learning_level: @tarent.learning_level, skill_id: @tarent.skill_id, user_id: @tarent.user_id } }
    assert_redirected_to tarent_url(@tarent)
  end

  test "should destroy tarent" do
    assert_difference('Tarent.count', -1) do
      delete tarent_url(@tarent)
    end

    assert_redirected_to tarents_url
  end
end
