# encoding: utf-8

require 'socket'

module Metamine
  class Connection
    include Protocol
    
    def initialize delegate
      @delegate = delegate
    end

    def establish
      @socket = TCPSocket.new 'maero.dk', 25565
      @delegate.connection_established

      until @socket.eof?
        @delegate.got_packet Packet.parse @socket.gets
      end

      @delegate.connection_terminated
    end
    
    def transmit name, *args
      protocol = Protocol.__send__ name, *args
      
      puts ">> #{protocol.join.inspect}"
      @socket.write "#{protocol.join}"
      @socket.flush
    end
    
  end
end
