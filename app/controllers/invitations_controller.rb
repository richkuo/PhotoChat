class InvitationsController <ApplicationController

   def create
     @user = User.find(params[:invitation][:uploader_id])
     current_event.add_uploader!(@user)
     respond_to do |format|
       format.html {redirect_to @user }
       format.js
     end
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
