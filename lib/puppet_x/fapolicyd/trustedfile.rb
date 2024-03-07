require 'puppet'
require 'open3'

# rubocop:disable Style/ClassAndModuleChildren
module PuppetX
  module Fapolicyd
    # Internal class for looking up data from Vault.
    class TrustedFile
      def self.get_file_info(fp:)
        if File.exist?(fp)
          size = File.size(fp)
          stdout_str, status = Open3.capture2('/usr/bin/sha256sum', stdin_data: fp)
          raise unless status.exitstatus == 0
          sha = stdout_str.split[0]
          "#{fp} #{size} #{sha}"
        else
          "##{fp} is trusted but does not currently exist on the machine"
        end
      end
    end
  end
end
