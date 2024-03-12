# frozen_string_literal: true

require_relative '../../../puppet_x/fapolicyd/trustedfile'

# A function that returns the trusted application's file information in the format `<file absolute path> <file size> <file sha256 hash>`
Puppet::Functions.create_function(:"fapolicyd::get_trusted_file_info") do
  # @param fp The trusted application/file's absolute path
  # @return [String] If second argument is less than 10, the name of one item.
  # @example Calling the function to get the file info for `/tmp/ls`
  #   example('/tmp/ls')
  #
  # @api private
  #
  dispatch :get_trusted_file_info do
    param 'String', :fp
    return_type 'String'
  end

  def get_trusted_file_info(fp)
    PuppetX::Fapolicyd::TrustedFile.get_file_info(filepath: fp)
  end
end
