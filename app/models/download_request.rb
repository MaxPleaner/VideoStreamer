class DownloadRequest < ApplicationRecord
  after_create :push_to_pub_sub
  validates :status, :url, :name, presence: true

  def status=(val)
    super(val.blank? ? "new" : val)
  end

  def push_to_pub_sub
    GooglePubSub.push_download_request(self)
  end
end
