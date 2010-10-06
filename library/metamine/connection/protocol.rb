# encoding: utf-8

module Metamine
  class Connection
    module Protocol
    module_function
    
      Names = {
        0xff => :error,
        0x00 => :server_id,
        0x01 => :ping,
        0x02 => :level_initialize,
        0x03 => :level_data,
        0x04 => :level_loaded,
        0x06 => :set_block,
        0x07 => :spawn_player,
        0x08 => :player_update,
        0x09 => :player_update2,
        0x0a => :position_update,
        0x0b => :orentation_update,
        0x0c => :despawn_player,
        0x0d => :text_message,
        0x0e => :kick_message,
        0x0f => :usermode_changed
      }
      
      def identification username
        [?\x02, ?\x00, ?\x07, username, ?\x01]
      end
      
    end
  end
end