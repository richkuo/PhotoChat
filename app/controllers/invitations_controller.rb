class InvitationsController < ApplicationController
# Invitation class for keeping track of uploaders belonging to an event

  before_filter :signed_in_user

  def create
    @user = User.find_by_id(params[:invitation][:uploader_id])
    @event = Event.find_by_id(params[:invitation][:event_id])
    @event.add_uploader!(@user)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end

  def destroy
    @user = Invitation.find(params[:id]).uploader
    @event = Invitation.find(params[:id]).event
    @event.remove_uploader!(@user)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js
    end
  end

end
