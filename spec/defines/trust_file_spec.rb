# # frozen_string_literal: true

# require 'spec_helper'

# describe 'fapolicyd::trust_file' do
#   let(:pre_condition) { 'include fapolicyd' }
#   let(:title) { 'trusted_app' }
#   let(:params) do
#     {
#       trusted_apps: [
#         '/tmp/ls',
#       ],
#     }
#   end

#   on_supported_os.each do |os, os_facts|
#     context "on #{os}" do
#       let(:facts) { os_facts }

#       before(:each) do
#         Puppet::Parser::Functions.newfunction(:'fapolicyd::get_trusted_file_info', type: :rvalue) do |_args|
#           'expected value'
#         end
#       end

#       # it { is_expected.to compile }
#       it { is_expected.to contain_file('/etc/fapolicyd/trust.d/trusted_app') }
#       it { is_expected.to contain_file_line('trusted_app_/tmp/ls') }
#     end
#   end
# end
