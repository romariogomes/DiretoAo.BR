require 'test_helper'

class LawProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @law_project = law_projects(:one)
  end

  test "should get index" do
    get law_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_law_project_url
    assert_response :success
  end

  test "should create law_project" do
    assert_difference('LawProject.count') do
      post law_projects_url, params: { law_project: { date: @law_project.date, description: @law_project.description, law_number: @law_project.law_number } }
    end

    assert_redirected_to law_project_url(LawProject.last)
  end

  test "should show law_project" do
    get law_project_url(@law_project)
    assert_response :success
  end

  test "should get edit" do
    get edit_law_project_url(@law_project)
    assert_response :success
  end

  test "should update law_project" do
    patch law_project_url(@law_project), params: { law_project: { date: @law_project.date, description: @law_project.description, law_number: @law_project.law_number } }
    assert_redirected_to law_project_url(@law_project)
  end

  test "should destroy law_project" do
    assert_difference('LawProject.count', -1) do
      delete law_project_url(@law_project)
    end

    assert_redirected_to law_projects_url
  end
end
