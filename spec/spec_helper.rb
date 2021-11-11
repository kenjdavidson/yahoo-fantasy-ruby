# frozen_string_literal: true

require 'bundler/setup'
require 'yahoo_fantasy'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def load_fantasy_content(filepath, debug: false)
  let(:xml) { File.read(filepath.to_s) }
  let(:fantasy_content) do
    representer = YahooFantasy::XML::FantasyContentRepresenter.new(YahooFantasy::Resource::FantasyContent.new)
    representer.extend(Representable::Debug) if debug
    representer.from_xml(xml)
  end
end
