module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_chef

    def connect
      self.current_chef = find_current_user
    end

    def disconnect
      #code
    end

    protected
    def find_current_user
      if current_chef = env['warden'].user
        current_chef
      else
        reject_unauthorized_connection

      end
    end
  end
end
