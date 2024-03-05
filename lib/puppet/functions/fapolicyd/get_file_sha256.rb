# frozen_string_literal: true

require 'open3'

# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:"fapolicyd::get_file_sha256") do
  dispatch :get_file_sha256 do
    param 'String', :file_path
    return_type 'String'
  end
  # the function below is called by puppet and and must match
  # the name of the puppet function above. You can set your
  # required parameters below and puppet will enforce these
  # so change x to suit your needs although only one parameter is required
  # as defined in the dispatch method.
  def get_file_sha256(file_path)
    stdout_str, status = Open3.capture2('/usr/bin/sha256sum', stdin_data: file_path)
    raise unless status.exitstatus == 0
    stdout_str.split[0]
  end

  # you can define other helper methods in this code block as well
end
