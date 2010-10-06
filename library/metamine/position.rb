# encoding: utf-8

module Metamine
  class Position
    attr_accessor :heading, :pitch, :x, :y
    
    def initialize x = 0, y = 0, pitch = 0, heading = 0
      @heading, @pitch, @x, @y = heading, pitch, x, y
    end
    
    def update! x, y = 0, pitch = 0, heading = 0
      @heading, @pitch, @x, @y = heading, pitch, x, y
    end
  end
end