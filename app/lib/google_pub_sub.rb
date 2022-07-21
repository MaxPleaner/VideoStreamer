require 'google/cloud/pubsub'

class GooglePubSub
  Client = Google::Cloud::PubSub.new(
    project_id: ENV.fetch("GCS_PROJECT_ID"),
    credentials: JSON.parse(ENV.fetch("GCS_CREDENTIALS"))
  )

  SendRequestTopic = Client.topic "download-requests"
  SendRequestSubscription = Client.subscription "download-requests-subscription"
  ReceiveUpdateTopic = Client.topic "download-update"
  ReceiveUpdateSubscription = Client.subscription "download-update-subscription"
  
  def self.push(topic, message_string)
    topic.publish(message_string)
  end

  def self.push_download_request(download_request)
    attrs = download_request.attributes.slice :id, :name, :url
    push(SendRequestTopic, attrs.to_json)
  end

  # You will need to call `sleep` elsewhere, if required.
  def self.add_subscriber(topic, &blk)
    subscriber = topic.listen threads: { callback: 1 } do |msg|
      msg.acknowledge!
      blk.call(msg)
    end
    at_exit { subscriber.stop!(10) }
    subscriber.start

    subscriber
  end

  # run on worker to handle requests
  def self.add_download_request_listener
    add_subscriber SendRequestSubscription do |msg|
      # puts "Data: #{received_message.message.data}, published at #{received_message.message.published_at}"
    end
  end

  # run on web server to receive updates
  def self.add_update_listener
    add_subscriber ReceiveUpdateSubscription do |msg|
      # puts "Data: #{received_message.message.data}, published at #{received_message.message.published_at}"
    end
  end

end
