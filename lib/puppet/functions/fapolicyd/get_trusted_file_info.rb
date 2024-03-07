# frozen_string_literal: true

require_relative '../../../puppet_x/fapolicyd/trustedfile'

# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:"fapolicyd::get_trusted_file_info") do
  dispatch :get_trusted_file_info do
    param 'String', :fp
    return_type 'String'
  end

  def get_trusted_file_info(fp)
    PuppetX::Fapolicyd::TrustedFile.get_file_info(filepath: fp)
  end
end
