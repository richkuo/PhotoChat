class PagesController < ApplicationController

  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @events = Event.paginate(page: params[:page])
    end
    @user = User.new unless signed_in?
  end

  def about
  end

  def contact
  end

  def what
  end

  def feedback
    @micropost = current_user.microposts.build
    @microposts = Micropost.paginate(page: params[:page])
  end

end
