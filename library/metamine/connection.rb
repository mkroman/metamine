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
        buffer = @socket.readbyte.chr << @socket.readpartial(1024)
        @delegate.got_packet Packet.parse buffer
      end

      @delegate.connection_terminated
    end
    
    def transmit name, *args
      packet = Protocol.__send__ name, *args
      
      puts " \e[32m→\e[0m | \e[1m#{packet.name.to_s.ljust 15}\e[0m | #{packet.to_s.inspect}"
      @socket.write "#{packet}"
      @socket.flush
    end
    
  end
end
