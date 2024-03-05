# frozen_string_literal: true

require 'open3'

# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:"fapolicyd::get_trusted_file_info") do
  dispatch :get_trusted_file_info do
    param 'String', :fp
    return_type 'String'
  end

  def get_trusted_file_info(fp)
    size = File.size(fp)
    stdout_str, status = Open3.capture2('/usr/bin/sha256sum', stdin_data: fp)
    raise unless status.exitstatus == 0
    sha = stdout_str.split[0]
    "#{fp} #{size} #{sha}"
  end
end
