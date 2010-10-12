# encoding: utf-8

module Metamine
  class Client
    module Handling
    protected
      
      def got_termination packet
        puts "!! ERROR !! ~ #{packet.data.inspect}"
      end
      
    end
  end
end