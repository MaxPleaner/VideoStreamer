# ===================================================
# This class follows interface defined in Storage.
# Any new methods here should be added to Storage and Gcs as well.
#
# Note that the interface was originally written for Gcs and later
# adapted to the filesystem, so the functionality of the methods here
# doesn't always exactly match their names.
# ===================================================

class Filesystem
  FILMS_DIR = ENV["FILMS_DIR"]

  def self.signed_url(file)
    # binding.pry
    "#"
  end

  # In this case, we don't actually have to upload anything,
  # And the index file can be built dynamically, so this is a no-op
  def self.sync_folder(local_folder); end

  def self.get_files_in_folder(prefix)
    Dir.glob("#{File.join(FILMS_DIR, sanitize(prefix))}/**/*").to_a.
      reject { |path| File.directory?(path) }.
      map do |name|
        OpenStruct.new(
          name: name,
          size: File.size(name)
        )
      end
  end

  def self.read_file(name)
    File.read(File.join(FILMS_DIR, sanitize(name)))
  end

  # This really just returns a list of film names
  def self.download_index_file
    Dir.glob("#{FILMS_DIR}/*").
      select { |path| File.directory?(path) }.
      map { |path| File.basename(path) }
  end

  class << self
    def sanitize(path)
      path.gsub("..", "")
    end
  end
end
