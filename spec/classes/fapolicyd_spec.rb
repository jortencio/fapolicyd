# frozen_string_literal: true

require 'spec_helper'

describe 'fapolicyd' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          package_ensure: 'present',
          service_ensure: 'running',
          service_enable: true,
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_package('fapolicyd') }
      it { is_expected.to contain_service('fapolicyd') }
    end
  end
end
