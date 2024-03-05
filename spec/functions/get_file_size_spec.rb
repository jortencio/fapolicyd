# frozen_string_literal: true

require 'spec_helper'

describe 'fapolicyd::get_file_size' do
  it do
    allow(File).to receive(:size).with('/tmp/ls').and_return(10)
    is_expected.to run.with_params('/tmp/ls')
  end
end
