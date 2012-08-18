class PicturesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :destroy]

   def new
     @picture = Picture.new(:event_id => params[:event_id], :user_id => current_user.id)
   end

   def index
     @pictures = Picture.paginate(page: params[:page])
   end

   def create
     @picture = Picture.new(params[:picture])
     if @picture.save
       flash[:success] = "Successfully uploaded the picture! Feel free to add more."
       redirect_to (:back)
     else
       flash[:error] = "You did not select a file to upload."
       redirect_to @event
     end
   end

   def destroy
     @picture = Picture.find(params[:id])
     @picture.destroy
     flash[:notice] = "Successfully deleted the picture."
     redirect_to (:back)
   end

end
