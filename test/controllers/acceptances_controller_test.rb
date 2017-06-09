require 'test_helper'

class AcceptancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acceptance = acceptances(:one)
  end

  test "should get index" do
    get acceptances_url
    assert_response :success
  end

  test "should get new" do
    get new_acceptance_url
    assert_response :success
  end

  test "should create acceptance" do
    assert_difference('Acceptance.count') do
      post acceptances_url, params: { acceptance: { like: @acceptance.like } }
    end

    assert_redirected_to acceptance_url(Acceptance.last)
  end

  test "should show acceptance" do
    get acceptance_url(@acceptance)
    assert_response :success
  end

  test "should get edit" do
    get edit_acceptance_url(@acceptance)
    assert_response :success
  end

  test "should update acceptance" do
    patch acceptance_url(@acceptance), params: { acceptance: { like: @acceptance.like } }
    assert_redirected_to acceptance_url(@acceptance)
  end

  test "should destroy acceptance" do
    assert_difference('Acceptance.count', -1) do
      delete acceptance_url(@acceptance)
    end

    assert_redirected_to acceptances_url
  end
end
