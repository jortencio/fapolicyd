# frozen_string_literal: true

require 'spec_helper'

describe 'fapolicyd::format_rule' do
  # please note that these tests are examples only
  # you will need to replace the params and return value
  # with your expectations
  it do
    params = {
      'decision' => 'allow',
      'perm' => 'execute',
      'subjects' => [
        {
          'type' => 'exe',
          'setting' => '/usr/bin/bash',
        },
        {
          'type' => 'trust',
          'setting' => '1',
        },
      ],
      'objects' => [
        {
          'type' => 'path',
          'setting' => '/tmp/ls',
        },
        {
          'type' => 'ftype',
          'setting' => 'application/x-executable'
        },
        {
          'type' => 'trust',
          'setting' => '0'
        },
      ]
    }
    is_expected.to run.with_params(params).and_return('allow perm=execute exe=/usr/bin/bash trust=1 : path=/tmp/ls ftype=application/x-executable trust=0')
  end
end
