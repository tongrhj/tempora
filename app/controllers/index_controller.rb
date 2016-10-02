class IndexController < ApplicationController
  def index
  end

  def show_tweets
    @search_campaign_id = params[:campaign_id].to_i
    @campaign = sample_data.find { |cmp|
      cmp[:campaign_id] == @search_campaign_id
    }
    load_tweets(@campaign[:campaign_name])
  end
end
