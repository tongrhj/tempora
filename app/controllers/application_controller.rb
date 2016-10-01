class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :load_tweets

  def load_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key     = ENV['twitter_consumer_key']
      config.consumer_secret  = ENV['twitter_consumer_secret']
    end

    @tweets = []
    begin
      client.search("refr.cc", result_type: "recent").take(3).collect do |tweet|
        @tweets << "#{tweet.user.screen_name}: #{tweet.text} | Date: #{tweet.created_at}"
      end
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end
end
