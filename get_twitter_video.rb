require 'twitter'
require 'open-uri'
require 'date'

class GetTwitterVideo

  def initialize(consumer_key, consumer_secret)
    @twitter_client = Twitter::REST::Client.new(
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
    )
  end

  def get_twitter_video(twitter_id)

    tweets = @twitter_client.search("from:#{twitter_id} filter:native_video", result_type: "recent")

    tweets.each_with_index {|tweet, i|
      begin
        url = tweet.media[0].video_info.variants[0].url.to_s
        open(url) do |file|
          open("#{tweet.created_at}.mp4", "w+b") {|out|
            out.write(file.read)
          }
        end
      rescue
        p "例外"
      end
    }
  end

end