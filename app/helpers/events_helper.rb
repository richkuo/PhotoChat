module EventsHelper

   def current_event=(event)
     @current_event = event
   end

   def current_event
     @current_event ||= Event.find_by_id(params[:id])
   end

   def current_event?(event)
     event == current_event
   end

   def viewer_access
   end

   def uploader_access
   end

   def uploader?(other_user)
     invitations.find_by_uploader_id(other_user.id)
   end

   def host?
     current_user.id == @event.host_id
   end



end
