class TweetsController < ApplicationController
  def  index
    @tweets = Tweet.order("create_at DESK").page(params[:page]).per(5)

  end

  def new 
  end
  def create
    Tweet.create(tweet_params)

  end
private
  def tweet_params
      params.permit(:name, :image ,:text)
  end
end
