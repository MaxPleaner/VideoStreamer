require 'google/cloud/storage'

class Gcs
	STORAGE = Google::Cloud::Storage.new(
	  project_id: ENV.fetch("GCS_PROJECT_ID"),
	  credentials: JSON.parse(ENV.fetch("GCS_CREDENTIALS"))
	)

	BUCKET = STORAGE.bucket(ENV.fetch("GCS_BUCKET_NAME"))
	INDEX_FILE_NAME = "0_index.json"

	def self.sync_folder(local_folder)
		# This uploads everything in local_folder to the bucket
		`gsutil -m cp -n -r #{local_folder}/* gs://#{BUCKET.name}`

		# Here we create an index file which lists all the top-level directories
		dirs = Dir.glob("#{local_folder}/*").
			select { |path| File.directory?(path) }.
			map { |dir| dir.gsub("#{local_folder}/", "") }
		tmp_path = Tempfile.new.
			tap { |tmp| tmp.write(dirs.to_json) }.
			tap(&:close).
			path
		BUCKET.upload_file(tmp_path, INDEX_FILE_NAME)
	end
end