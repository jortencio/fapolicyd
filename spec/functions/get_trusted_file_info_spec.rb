# frozen_string_literal: true

require 'spec_helper'

require_relative '../fixtures/modules/fapolicyd/lib/puppet_x/fapolicyd/trustedfile'

describe 'fapolicyd::get_trusted_file_info' do
  it do
    expect(PuppetX::Fapolicyd::TrustedFile).to receive(:get_file_info).with('/tmp/ls').and_return('/tmp/ls 143232 d27fe83da7c4b3be85195b604fc141e1d60cb8238fe6de2cf5e6ee712ababe1e')
    is_expected.to run.with_params('/tmp/ls').and_return('/tmp/ls 143232 d27fe83da7c4b3be85195b604fc141e1d60cb8238fe6de2cf5e6ee712ababe1e')
  end
end
