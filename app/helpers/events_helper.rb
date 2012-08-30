module EventsHelper

   def current_event=(event)
     @current_event = event
   end

   def current_event
     @current_event ||= Event.find_by_id(params[:event_id])
   end

   def current_event?(event)
     event == current_event
   end

   def host?(event)
     current_user.id == event.host_id
   end

   def uploader?(other_user)
     Invitation.find_by_uploader_id(other_user.id)
   end

end
