# frozen_string_literal: true

require 'spec_helper'
require_relative '../fixtures/modules/fapolicyd/lib/puppet_x/fapolicyd/trustedfile'

describe 'fapolicyd::trust_file' do
  let(:title) { 'trusted_app' }
  let(:pre_condition) do
    'include fapolicyd'
  end

  let(:params) do
    {
      trusted_apps: [
        '/tmp/ls',
      ],
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      before(:each) do
        allow(PuppetX::Fapolicyd::TrustedFile).to receive(:get_file_info).with('/tmp/ls').and_return('/tmp/ls test test')
      end

      it { is_expected.to compile }
      it { is_expected.to contain_file('/etc/fapolicyd/trust.d/trusted_app') }
      it { is_expected.to contain_file_line('trusted_app_/tmp/ls') }
    end
  end
end
