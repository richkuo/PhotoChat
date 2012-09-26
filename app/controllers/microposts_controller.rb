class MicropostsController < ApplicationController
# Class for creating tweets
# Currently being used for feedback comments

  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def index
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Thank you for your feedback!"
      redirect_to(:back)
    else
      @feed_items = []
      flash[:error] = "Feedback was incomplete"
      redirect_to(:back)
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

end
