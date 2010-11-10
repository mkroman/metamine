# encoding: utf-8
# encoding: utf-8

module Metamine
  class Connection
    class Packet
      attr_accessor :name, :buffer
      
      def self.parse data
        new(data[0].ord).tap do |this|
          this.buffer = data[1..-1]
        end
      end
      
      def initialize byte
        @name   = Protocol::Names[byte]
        @buffer = [byte].pack ?w
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
      
      def to_s;    @buffer end
      def inspect; @buffer.inspect end
    end
  end
end
