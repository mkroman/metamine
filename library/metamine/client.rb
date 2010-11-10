# encoding: utf-8

module Metamine
  class Client
    class AuthenticationError < StandardError; end
    include Handling

    AuthenticationURI = 'http://www.minecraft.net/game/getversion.jsp?user=%s&password=%s&version=%d'
    VerificationURI   = 'http://www.minecraft.net/game/joinserver.jsp?user=%s&sessionId=%s&serverId=%s'
    LauncherVersion = 12
    
    def initialize options
      @connection = Connection.new self
      @authenticated = false
      @options = options
    end

    def connect
      @connection.establish
    end

    def connection_established
      puts "-- Connection has been established"

      @connection.transmit :handshake, @options[:username]
    end

    def connection_terminated
      puts "-- Connection has been terminated"
    end

    def got_packet packet
      puts " \e[31m←\e[0m | \e[1m#{packet.name.to_s.ljust 15}\e[0m | #{packet.to_s.inspect}"
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

      open AuthenticationURI % [@options[:username], @options[:password], LauncherVersion] do |response|
        body = response.read

        case body
        when 'Old Version'
          raise AuthenticationError, "Metamine::Client::LauncherVersion is too old."
        when 'Bad login'
          raise AuthenticationError, "Invalid user credentials."
        else
          keys = body.split ?:
          { version: keys[0], ticket: keys[1], username: keys[2], token: keys[3] }
        end
      end
    end

    def authenticate_server hash
      return if @authenticated

      open VerificationURI % [@options[:username], credentials[:token], hash] do |response|
        data = response.read
        if data == 'OK'
          @authenticated = true
          @connection.transmit :identification, @options[:username]
        end
      end
    end
    
  end
end
