require 'test_helper'

class ConferenceRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conference_room = conference_rooms(:one)
  end

  test "should get index" do
    get conference_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_conference_room_url
    assert_response :success
  end

  test "should create conference_room" do
    assert_difference('ConferenceRoom.count') do
      post conference_rooms_url, params: { conference_room: { name: @conference_room.name } }
    end

    assert_redirected_to conference_room_url(ConferenceRoom.last)
  end

  test "should show conference_room" do
    get conference_room_url(@conference_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_conference_room_url(@conference_room)
    assert_response :success
  end

  test "should update conference_room" do
    patch conference_room_url(@conference_room), params: { conference_room: { name: @conference_room.name } }
    assert_redirected_to conference_room_url(@conference_room)
  end

  test "should destroy conference_room" do
    assert_difference('ConferenceRoom.count', -1) do
      delete conference_room_url(@conference_room)
    end

    assert_redirected_to conference_rooms_url
  end
end
