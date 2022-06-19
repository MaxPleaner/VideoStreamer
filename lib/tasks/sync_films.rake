task :sync_films, [:src_path] => :environment do |t, args|
 	src_path = args[:src_path] || ENV["FILMS_DIR"]
 	Gcs.sync_folder(src_path)
end
