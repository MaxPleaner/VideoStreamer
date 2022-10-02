# ===================================================
# This class follows interface defined in Storage.
# Any new methods here should be added to Storage and Gcs as well.
#
# Note that the interface was originally written for Gcs and later
# adapted to the filesystem, so the functionality of the methods here
# doesn't always exactly match their names.
# ===================================================

require 'tempfile'
require 'digest' 

class Filesystem
  FILMS_DIR = ENV["FILMS_DIR"]
  SECURE_LINK_SECRET = ENV["SECURE_LINK_SECRET"]

  def self.signed_url(file)
    name = file.name.gsub(FILMS_DIR, "")
#    secure_link_id = Digest::MD5.hexdigest "#{name}#{SECURE_LINK_SECRET}"
#     return "/films/video_file?name=#{CGI.escape(name)}"
#    binding.pry if name.include?(" ")
#    "/video_streamer_file/#{secure_link_id}/#{CGI.escape(name)}"
     "/video_streamer_file_authenticated/#{CGI.escape(name)}"
  end

  # In this case, we don't actually have to upload anything,
  # And the index file can be built dynamically, so this is a no-op
  def self.sync_folder(local_folder); end

  def self.get_files_in_folder(prefix)
    files = Dir.glob("#{File.join(FILMS_DIR, sanitize(prefix))}/**/*").to_a.
      reject { |path| File.directory?(path) }
#    files.each do |file|
#      if file.include?(" ") # doesnt work with nginx
#        parts = file.split("/")
#        parts.each.with_index do |part, idx|
#	  next if part.empty?
#          next unless part.include?(" ")
#          path = parts[0..idx].join("/")
#          binding.pry
#        end
#      end
#    end
      
    files.map do |name|
        OpenStruct.new(
          name: name,
          size: File.size(name)
        )
      end
  end

  def self.local_file_path(name)
    File.join(FILMS_DIR, sanitize(name))
  end

  # This really just returns a list of film names
  def self.download_index_file
    Dir.glob("#{FILMS_DIR}/*").
      select { |path| File.directory?(path) }.
      map { |path| File.basename(path) }
  end

  class << self
    def sanitize(path)
      path = File.join(FILMS_DIR, path.gsub(FILMS_DIR, ""))

      unless File.exists?(path) && File.realpath(path).start_with?(FILMS_DIR)
        raise "file not accessible"
      end

      File.realpath(path).gsub(FILMS_DIR, "")
    end
  end
end
