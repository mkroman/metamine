# encoding: utf-8

module Metamine
  class Client
    def initialize options
      @connection = Connection.new self
      @options = options
    end

    def connect
      @connection.establish
    end

    def connection_established
      puts "-- Connection has been established"
    end

    def connection_terminated
      puts "-- Connection has been terminated"
    end

    def got_packet packet
      # …
    end
  end
end
