class InvitationsController <ApplicationController

   before_filter :signed_in_user

   def create
     @user = User.find_by_id(params[:invitation][:uploader_id])
     current_event.add_uploader!(@user)
     #respond_to do |format|
      # format.html { redirect_to uploaders_path}
       #format.js
     #end
   end

   def destroy
     @user = Invitation.find(params[:id]).uploader
     current_event.remove_uploader!(@user)
     respond_to do |format|
       format.html { redirect_to @user }
       format.js
     end
   end

end
