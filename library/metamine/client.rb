# encoding: utf-8

module Metamine
  class Client
    include Handling
    
    def initialize options
      @username   = options[:username] or "missing username"
      @connection = Connection.new self
      
      @options = options
    end

    def connect
      @connection.establish
    end

    def connection_established
      puts "-- Connection has been established"
      @connection.transmit :handshake, 'mkroman'
    end

    def connection_terminated
      puts "-- Connection has been terminated"
    end

    def got_packet packet
      puts "<< #{packet.to_s.inspect}"
      method_name = :"got_#{packet.name}"
      
      if respond_to? method_name
        __send__ method_name, packet
      end
    end
    
  private
    
    def passhash; @passhash ||= retrieve_passhash end
    
    def retrieve_passhash
      
    end
  end
end
