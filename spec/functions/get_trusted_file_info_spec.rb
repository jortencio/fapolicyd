# frozen_string_literal: true

require 'spec_helper'

describe 'fapolicyd::get_trusted_file_info' do
  it do
    allow(File).to receive(:size).with('/tmp/ls').and_return(10)
    status = instance_double(Process::Status, exitstatus: 0)
    allow(Open3).to receive(:capture2).with('/usr/bin/sha256sum', stdin_data: '/tmp/ls').and_return(['d27fe83da7c4b3be85195b604fc141e1d60cb8238fe6de2cf5e6ee712ababe1e \n', status])
    is_expected.to run.with_params('/tmp/ls')
  end
end
