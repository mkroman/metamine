# encoding: utf-8

module Metamine
  class Packet
    Lengths = {
      0x00 => 131, 0x01 => 1,
      0x02 => 1,   0x03 => 1028,
      0x04 => 7,   0x06 => 8,
      0x07 => 74,  0x08 => 10,
      0x09 => 7,   0x0a => 5,
      0x0b => 4,   0x0c => 2,
      0x0d => 66,  0x0e => 65,
      0x0f => 2,   0xff => 3,
    }

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

    def self.parse data
      type = data[0].ord

      puts "<< #{Names[type].capitalize}: #{data.inspect}"
    end

    def initialize
      # …
    end
  end
end
