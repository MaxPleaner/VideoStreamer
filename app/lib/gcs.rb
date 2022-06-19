class Gcs
	STORAGE = Google::Cloud::Storage.new(
	  project_id: ENV.fetch("GCS_PROJECT_ID"),
	  credentials: JSON.parse(ENV.fetch("GCS_CREDENTIALS"))
	)
end