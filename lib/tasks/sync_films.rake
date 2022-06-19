namespace :films do
	task :upload, [:src_path] => :environment do |t, args|
	 	src_path = args[:src_path] || ENV["FILMS_DIR"]
	 	Gcs.sync_folder(src_path)
	end
	task :sync_db => :environment do |t|
	 	Film.sync_db_with_gcs
	end	
end
