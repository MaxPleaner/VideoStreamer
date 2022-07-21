require "application_system_test_case"

class DownloadRequestsTest < ApplicationSystemTestCase
  setup do
    @download_request = download_requests(:one)
  end

  test "visiting the index" do
    visit download_requests_url
    assert_selector "h1", text: "Download requests"
  end

  test "should create download request" do
    visit download_requests_url
    click_on "New download request"

    fill_in "Name", with: @download_request.name
    fill_in "Status", with: @download_request.status
    fill_in "Url", with: @download_request.url
    click_on "Create Download request"

    assert_text "Download request was successfully created"
    click_on "Back"
  end

  test "should update Download request" do
    visit download_request_url(@download_request)
    click_on "Edit this download request", match: :first

    fill_in "Name", with: @download_request.name
    fill_in "Status", with: @download_request.status
    fill_in "Url", with: @download_request.url
    click_on "Update Download request"

    assert_text "Download request was successfully updated"
    click_on "Back"
  end

  test "should destroy Download request" do
    visit download_request_url(@download_request)
    click_on "Destroy this download request", match: :first

    assert_text "Download request was successfully destroyed"
  end
end
