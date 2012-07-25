class EventsController < ApplicationController
   before_filter :signed_in_user, only: [:uploaders, :create, :destroy]
   before_filter :host_user, only: [:uploaders, :destroy]


   def index
     @users = Event.paginate(page: params[:page])
   end

   def uploaders
     @event = Event.find(params[:id])
     @users = User.paginate(page: params[:page])
   end

   def _uploader_form
     @user = User.find(params[:id])
   end

   def viewers
   end

   def show
     @event = Event.find(params[:id])
   end

   def new
     @event = Event.new
   end

   def create
     @event = current_user.events.build(params[:event])
     if @event.save
       flash[:success] = "Event created!"
       @event.host_id = current_user.id
       redirect_to @event
     else
       redirect_to 'new'
     end
   end

   def destroy
     @event.destroy
     redirect_to root_path
   end

   private

     def host_user
       redirect_to root_path unless current_user.id == current_event.host_id
     end


end
