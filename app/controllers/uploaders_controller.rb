class UploadersController < ApplicationController
  before_filter :signed_in_user
# Uploaders are users who have been invited to an event

  def index
    @event = Event.find(params[:event_id])
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @event = Event.find_by_id(params[:event_id])
  end

end
