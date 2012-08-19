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
     #@picture.image = params[:picture][:image]
     if @picture.save
       flash[:success] = "Successfully uploaded the picture! Feel free to add more."
       respond_to do |format|
         format.html {
           render :json => [@picture.to_jq_upload].to_json,
           :content_type => 'text/html',
           :layout => false
         }
         format.json{
           render :json => [@picture.to_jq_upload].to_json
         }
         end
     else
       flash[:error] = "You did not select a file to upload."
       render :json => [{:error => "custom_failure"}], :status => 304
     end
   end

   def destroy
     @picture = Picture.find(params[:id])
     @picture.destroy
     flash[:notice] = "Successfully deleted the picture."
     render :json => true
   end

end
