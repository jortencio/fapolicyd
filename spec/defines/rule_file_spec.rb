# frozen_string_literal: true

require 'spec_helper'

describe 'fapolicyd::rule_file' do
  let(:title) { 'myapps' }
  let(:pre_condition) do
    'include fapolicyd'
  end

  let(:params) do
    {
      priority: 80,
      comment: '80-myapps.rules',
      rules: [
        {
          decision: 'allow',
          perm: 'execute',
          subjects: [
            {
              type: 'exe',
              setting: '/usr/bin/bash',
            },
            {
              type: 'trust',
              setting: '1',
            },
          ],
          objects: [
            {
              type: 'path',
              setting: '/tmp/ls',
            },
            {
              type: 'ftype',
              setting: 'application/x-executable'
            },
            {
              type: 'trust',
              setting: '0'
            },
          ]
        },
      ],
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_file('/etc/fapolicyd/rules.d/80-myapps.rules') }
    end
  end
end
