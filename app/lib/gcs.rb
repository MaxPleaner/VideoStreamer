# ===================================================
# This class follows the public API defined in Storage.
# Any new methods here should be added to Storage and Filesystem as well.
# ===================================================

require 'google/cloud/storage'

class Gcs
	if ENV["USE_GCS"]&.downcase == "true"
		STORAGE = Google::Cloud::Storage.new(
		  project_id: ENV.fetch("GCS_PROJECT_ID"),
		  credentials: JSON.parse(ENV.fetch("GCS_CREDENTIALS"))
		)

		BUCKET = STORAGE.bucket(ENV.fetch("GCS_BUCKET_NAME"))
		INDEX_FILE_NAME = "0_index.json"
	end

	def self.signed_url(file)
		file.signed_url(expires: 604800)
	end

	def self.sync_folder(local_folder)
		# This uploads everything in local_folder to the bucket
		cmd = "gsutil -m rsync -r -d #{local_folder} gs://#{BUCKET.name}"
		puts cmd
		`#{cmd}`

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

	def self.get_files_in_folder(prefix)
		BUCKET.files(prefix: prefix)
	end

	def self.read_file(name)
		BUCKET.file(name).download.read
	end

	def self.download_index_file
		JSON.parse(BUCKET.file(INDEX_FILE_NAME).download.read)
	end
end
