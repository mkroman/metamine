# encoding: utf-8

module Metamine
  class Client
    include Handling

    AuthenticationURI = 'http://www.minecraft.net/game/getversion.jsp?user=%s&password=%s&version=%d'
    LauncherVersion = 12
    
    def initialize options
      @connection = Connection.new self
      @options = options
    end

    def connect
      @connection.establish
    end

    def connection_established
      puts "-- Connection has been established"

      @connection.transmit :handshake, @options[:username]
      @connection.transmit :identification, @options[:username]
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

    def credentials; @credentials ||= authenticate end

    def authenticate
      raise AuthenticationError, "no username given" unless @options[:username]
      raise AuthenticationError, "no password given" unless @options[:password]

      open AuthenticationURI % [@options[:username], @options[:password], LauncherVersion] do |result|
        case result
        when 'Old Version'
          raise AuthenticationError, "Metamine::Client::LauncherVersion is too old."
        when 'Bad Login'
          raise AuthenticationError, "Invalid user credentials."
        else
          keys = result.read.split ?:
          p keys
          { version: keys[0], ticket: keys[1], username: keys[2], token: keys[3] }
        end
      end
    end
    
  end
end
