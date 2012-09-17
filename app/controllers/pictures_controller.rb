class PicturesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :destroy]

   def new
     @event = Event.find(params[:event_id])
     @picture = Picture.new(:user_id => current_user.id)

     respond_to do |format|
       format.html
       format.json { render json: @picture }
     end

   end

   def show
     @event = Event.find(params[:event_id])
     @picture = Picture.find(params[:id])
     @pictures = Picture.paginate(page: params[:page], :per_page => 1)
     @thumbs = Picture.paginate(page: params[:page], :per_page => 6)

     @commentable = @picture
     @comments = @commentable.comments
     @comment = Comment.new

   end

   def index
     @event = Event.find(params[:event_id])
     @pictures = Picture.paginate(page: params[:page], :per_page => 1)
     @thumbs = Picture.paginate(page: params[:page], :per_page => 6)
   end

   def create
     #@event = Event.find(params[:event_id])
     @picture = Picture.new(:event_id => params[:event_id], :user_id => current_user.id, :image => params[:image])
     if @picture.save
       flash[:success] = "Successfully uploaded the picture! Feel free to add more."
       respond_to do |format|
         format.html {
           render :json => [@picture.to_jq_upload].to_json,
           :content_type => 'text/html',
           :layout => false
         }
         format.json{
           render :json => [@picture.to_jq_upload].to_json, status: :created, location: @event
         }
         end
     else
       flash[:error] = "You did not select a file to upload."
       format.json { render json: @picture.errors, status: :unprocessable_entity }
     end
   end

   def destroy
     @picture = Picture.find(params[:id])
     @picture.destroy
     flash[:notice] = "Successfully deleted the picture."
     redirect_to(:back)
#     respond_to do |format|
#       format.html { redirect_to(:back) }
#       format.json {head :no_content }
#     end

   end

end
