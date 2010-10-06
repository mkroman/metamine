# encoding: utf-8

module Metamine
  class Connection
    class Packet
      attr_accessor :name, :data

      def self.parse data
        type = data[0].ord

        new(Protocol::Names[type]).tap do |this|
          this.data = data[1..-1]
        end
      end

      def initialize name, *args
        @name = name
      end
      
      def to_s
        String.new.tap do |line|
          line << Protocol::Names.invert[@name].chr
          line << @data
        end
      end
    end
  end
end