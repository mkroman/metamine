# encoding: utf-8

module Metamine
  class Connection
    module Protocol
    module_function
    
      Names = {
        0xFF => :termination,
        0x00 => :keep_alive,
        0x01 => :authentication,
        0x02 => :handshake,
        0x03 => :message,
        0x04 => :synchronize,
        0x06 => :set_block,
        0x07 => :spawn_player,
        0x08 => :player_update,
        0x09 => :player_update2,
        0x0A => :position_update,
        0x0B => :orentation_update,
        0x0C => :despawn_player,
        0x0D => :text_message,
        0x0E => :kick_message,
        0x0F => :usermode_changed
      }
      
      def ping
        Packet 0x00
      end
      
      def handshake username
        packet 0x02 do
          String username
        end
      end
      
      def identification username, password = 'Password'
        packet 0x01 do
          Integer 2
          String  username
          String  password
        end
      end
      
      def packet name, &block
        Packet.new(name).tap do |this|
          this.instance_eval &block
        end
      end
      
    end
  end
end