# ===================================================
# This class defines a common API that is implemented by multiple adapters.
# Any new methods here should be added to Gcs and Filesystem as well.
# Only class methods are supported.
# ===================================================

class Storage
  Adapter = ENV["USE_GCS"]&.downcase == "true" ? Gcs : Filesystem

  class << self
    %i[
      signed_url
      sync_folder
      get_files_in_folder
      read_file
      download_index_file
    ].each { |fn| delegate fn, to: Adapter }
  end
end

