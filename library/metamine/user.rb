# encoding: utf-8

module Metamine
  class User
    def initialize username
      @username = username
      @position = Position.new
    end
    
    def position= *args; position.update! *args end
  end
end