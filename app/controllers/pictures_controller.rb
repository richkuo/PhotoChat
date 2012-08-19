class PicturesController < ApplicationController
before_filter :signed_in_user, only: [:new, :create, :destroy]

   def new
     @picture = Picture.new(:user_id => current_user.id)

     respond_to do |format|
       format.html
       format.json { render json: @picture }
     end

   end

   def show
     @picture = Picture.find(params[:id])
   end

   def index
     @pictures = Picture.paginate(page: params[:page])
   end

   def create
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
           render :json => [@picture.to_jq_upload].to_json, status: :created, location: @picture
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

     respond_to do |format|
       format.html { redirect_to pictures_url }
       format.json {head :no_content }
     end

   end

end
