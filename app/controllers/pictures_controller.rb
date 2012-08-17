class PicturesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :destroy]

   def new
     @picture = Picture.new(:event_id => params[:event_id])
   end

   def index
   end

   def create
     @picture = Picture.new(params[:picture])
     if @picture.save
       flash[:success] = "Successfully uploaded the picture! Feel free to add more."
       # hardcoding the event id because current_event returns an error
       #future iterations should have the @picture.event_id
       # set to the actual event id, not 1
       # @picture.event_id = 1
       @picture.user_id = current_user.id
       redirect_to new_picture_path
     else
       flash[:error] = "You did not select a file to upload."
       redirect_to @event
     end
   end

   def destroy
   end

end
