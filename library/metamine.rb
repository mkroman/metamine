# encoding: utf-8

require 'metamine/connection/protocol'
require 'metamine/connection/packet'
require 'metamine/client/handling'
require 'metamine/connection'
require 'metamine/client'
require 'open-uri'

module Metamine
  Version = 0, 0, 1

module_function
  
  def connect *args, &block
    Client.new(*args).tap do |this|
      this.instance_eval &block
    end.connect
  end
end
