# encoding: utf-8

require 'metamine/client'
require 'metamine/packet'
require 'metamine/connection'

module Metamine
  Version = [0, 0, 1]

module_function
  
  def connect *args, &block
    Client.new(*args).tap do |this|
      this.instance_eval &block
    end.connect
  end
end
