# encoding: utf-8

module Metamine
  class Client
    module Handling
      
      def got_error packet
        puts "!! ERROR !! ~ #{packet.data.inspect}"
      end
      
    end
  end
end