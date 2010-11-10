# encoding: utf-8

module Metamine
  class Connection
    module Protocol
      Version = 4

    module_function
    
      Names = {
        0x00 => :keep_alive,
        0x01 => :authentication,
        0x02 => :handshake,
        0x03 => :message,
        0x04 => :synchronization,
        0x05 => :player_inventory,
        0x06 => :spawn_position,
        0x0D => :player_position,
        0x11 => :inventory_added,
        0x12 => :player_animated,
        0x14 => :entity_created_n,
        0x15 => :entity_collected,
        0x0C => :despawn_player,
        0x0D => :text_message,
        0x0E => :kick_message,
        0x0F => :usermode_changed
      }
      
      def ping
        Packet 0x00
      end
      
      def handshake username
        packet ?\x02 do
          String username
        end
      end
      
      def identification username, password = 'Password'
        packet ?\x01 do
          Integer Protocol::Version
          String  username
          String  password
          Long 0
          Byte 0
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
