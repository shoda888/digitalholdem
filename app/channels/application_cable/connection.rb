module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

   def connect
     self.current_player = find_verified_player
   end

   protected

   def find_verified_player
     if verified_player = Player.find_by(id: session['player_id'])
       verified_player
     else
       reject_unauthorized_connection
     end
   end

   def session
     cookies.encrypted[Rails.application.config.session_options[:key]]
   end
 end
end
