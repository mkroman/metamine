# encoding: utf-8

module Metamine
  class Client
    module Handling
    protected
      
      def got_termination packet
        #puts "!! ERROR !! ~ #{packet.inspect}"
      end

      def got_handshake packet
        authenticate_server packet.to_s[3..-1]
      end
      
    end
  end
end
