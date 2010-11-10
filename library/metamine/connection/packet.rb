# encoding: utf-8

module Metamine
  class Connection
    class Packet
      attr_accessor :name, :buffer
      
      def self.parse data
        new data
      end
      
      def initialize buffer
        @buffer = buffer
      end
      
      def Byte byte
        @buffer.<< [byte].pack ?w
      end
  
      def String string
        @buffer.<< [string.length].pack ?n
        @buffer.<< string
      end
  
      def Integer integer
        @buffer.<< [integer].pack ?N
      end

      def Long long
        @buffer.<< [long].pack ?G
      end

      def name; Protocol::Names[@buffer[0].ord] end
      
      def to_s;    @buffer end
      def inspect; @buffer.inspect end
    end
  end
end
