module EventsHelper

   def current_event=(event)
     @current_event = event
   end

   def current_event
     @current_event ||= Event.find_by_host_id(params[:id])
   end

   def current_event?(event)
     event == current_event
   end

   def viewer_access
   end

   def uploader_access
   end



end
