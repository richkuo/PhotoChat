class EventsController < ApplicationController
   before_filter :signed_in_user, only: [:create, :destroy]
   before_filter :correct_user, only: :destroy


   def index
     @events = Event.paginate(page: params[:page])
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
     def admin_user
       redirect_to(root_path) unless current_user.admin?
     end




end
