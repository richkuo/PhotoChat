class PagesController < ApplicationController

  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @event = current_user.events.build
    end
    @user = User.new unless signed_in?
  end

  def about
  end

  def contact
  end

end
