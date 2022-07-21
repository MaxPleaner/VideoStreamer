json.extract! download_request, :id, :name, :url, :status, :created_at, :updated_at
json.url download_request_url(download_request, format: :json)
