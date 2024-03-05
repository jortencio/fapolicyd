# frozen_string_literal: true

require 'spec_helper'

describe 'fapolicyd::get_file_exists' do
  it { is_expected.to run.with_params('/tmp/ls') }
end
