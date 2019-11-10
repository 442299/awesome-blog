class StaticpagesController < ApplicationController
  def home
    if logged_in?
      @micropost = Micropost.new
      @microposts = current_user.microposts
      render "users/home_feeds"
    end
  end

  def about
  end
end
