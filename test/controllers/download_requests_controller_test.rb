require "test_helper"

class DownloadRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @download_request = download_requests(:one)
  end

  test "should get index" do
    get download_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_download_request_url
    assert_response :success
  end

  test "should create download_request" do
    assert_difference("DownloadRequest.count") do
      post download_requests_url, params: { download_request: { name: @download_request.name, status: @download_request.status, url: @download_request.url } }
    end

    assert_redirected_to download_request_url(DownloadRequest.last)
  end

  test "should show download_request" do
    get download_request_url(@download_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_download_request_url(@download_request)
    assert_response :success
  end

  test "should update download_request" do
    patch download_request_url(@download_request), params: { download_request: { name: @download_request.name, status: @download_request.status, url: @download_request.url } }
    assert_redirected_to download_request_url(@download_request)
  end

  test "should destroy download_request" do
    assert_difference("DownloadRequest.count", -1) do
      delete download_request_url(@download_request)
    end

    assert_redirected_to download_requests_url
  end
end
