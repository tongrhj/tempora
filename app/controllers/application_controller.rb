class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_variables

  helper_method :sample_data

  def create_variables
    @search_term = ''
    @tweets = []
  end

  def load_tweets search_term
    client = Twitter::REST::Client.new do |config|
      config.consumer_key     = ENV['twitter_consumer_key']
      config.consumer_secret  = ENV['twitter_consumer_secret']
    end

    @search_term = search_term ? "#{search_term}.refr.cc" : ''
    begin
      client.search(@search_term, result_type: 'recent').take(3).collect do |tweet|
        @tweets << "#{tweet.user.screen_name}: #{tweet.text} | Date: #{tweet.created_at}"
      end
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end

  def sample_data
    [
      {
        campaign_id: 1,
        campaign_name: 'videoblocks',
        customers: [
          {
            customer_id: 1,
            name: 'Pidgey',
            unique_coupon_code: 'AAAAAA'
          },
          {
            customer_id: 2,
            name: 'Pikachu',
            unique_coupon_code: 'BBBBBB'
          },
          {
            customer_id: 3,
            name: 'Poliwag',
            unique_coupon_code: 'CCCCCC'
          }
        ]
      },
      {
        campaign_id: 2,
        campaign_name: 'nolahmattress',
        customers: [
          {
            customer_id: 1,
            name: 'Dexter',
            unique_coupon_code: '111111'
          },
          {
            customer_id: 2,
            name: 'David',
            unique_coupon_code: '222222'
          },
          {
            customer_id: 3,
            name: 'Dolly',
            unique_coupon_code: '333333'
          }
        ]
      },
      {
        campaign_id: 3,
        campaign_name: 'errornonsense',
        customers: [
          {
            customer_id: 1,
            name: 'Dexter',
            unique_coupon_code: '111111'
          },
          {
            customer_id: 2,
            name: 'David',
            unique_coupon_code: '222222'
          },
          {
            customer_id: 3,
            name: 'Dolly',
            unique_coupon_code: '333333'
          }
        ]
      }
    ]
  end
end
