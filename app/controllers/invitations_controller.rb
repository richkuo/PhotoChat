class InvitationsController <ApplicationController

   before_filter :signed_in_user

   def create
     @user = User.find_by_id(params[:invitation][:uploader_id])
     @event = Event.find_by_id(params[:invitation][:event_id])
     current_event.add_uploader!(@user)
     respond_to do |format|
       format.html { redirect_to event_user_path(@event, user)}
       format.js
     end
   end

   def destroy
     @user = Invitation.find(params[:id]).uploader
     @event = Event.find(params[:event_id])
     current_event.remove_uploader!(@user)
     respond_to do |format|
       format.html { redirect_to @user }
       format.js
     end
   end

end
