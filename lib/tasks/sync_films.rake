namespace :films do
	task :upload, [:src_path] => :environment do |t, args|
		ruby "./bin/convert_all.rb"
	 	# `./bin/download_missing_subs`

	 	src_path = args[:src_path] || ENV["FILMS_DIR"]
	 	Gcs.sync_folder(src_path)
		
		Dir.glob("#{src_path}/*").select do |folder|
		  subs = Dir.glob("#{folder}/**/*.vtt")
		  if subs.none?
		  	puts "MISSING SUBS: #{File.basename(folder)}"
		  end
		end	 	
	end
end
