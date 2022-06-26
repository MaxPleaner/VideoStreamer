namespace :films do
	task :upload, [:src_path] => :environment do |t, args|
	 	src_path = args[:src_path] || ENV["FILMS_DIR"]
	 	Gcs.sync_folder(src_path)
	end
	task :update_file_sizes => :environment do |t|
		include ActionView::Helpers::NumberHelper
	 	Film.all.each do |film|
	 		files = film.files
	 		size_mb = files.sum { |file| file.size / 1_000_000.0 }
	 		film.update(size: size_mb)
	 	end
	end	
end
