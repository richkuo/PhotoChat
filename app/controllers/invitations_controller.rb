class InvitationsController <ApplicationController

   def create
     @user = User.find(params[:relationship][:followed_id])
     current
   end

   def destroy
   end

end
