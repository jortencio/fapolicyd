# frozen_string_literal: true

require 'puppet'
require 'open3'

# rubocop:disable Style/ClassAndModuleChildren
module PuppetX
  module Fapolicyd
    # Internal class for looking up data from Vault.
    class TrustedFile
      def self.get_file_info(filepath:)
        if File.exist?(filepath)
          size = File.size(filepath)
          stdout_str, status = Open3.capture2('/usr/bin/sha256sum', stdin_data: filepath)
          raise unless status.exitstatus == 0
          sha = stdout_str.split[0]
          "#{filepath} #{size} #{sha}"
        else
          "##{filepath} is trusted but does not currently exist on the machine"
        end
      end
    end
  end
end
