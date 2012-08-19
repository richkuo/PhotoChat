module EventsHelper

   def current_event=(event)
     @current_event = event
   end

   def current_event
     @current_event ||= Event.find(params[:id])
   end

   def current_event?(event)
     event == current_event
   end

   def host?
     current_user.id == current_event.host_id
   end

end
