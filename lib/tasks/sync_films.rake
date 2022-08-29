namespace :films do
	task :upload, [:src_path] => :environment do |t, args|
		`./bin/convert_all`
	 	src_path = args[:src_path] || ENV["FILMS_DIR"]
	 	Gcs.sync_folder(src_path)
	end
end
