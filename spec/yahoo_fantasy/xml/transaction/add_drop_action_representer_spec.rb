# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Transaction::AddDropActionRepresenter do
  subject { YahooFantasy::XML::Transaction::AddDropActionRepresenter }

  context 'add request' do
    it 'should serialize correctly' do
      request = YahooFantasy::Resource::Transaction::AddDropAction.add('{team_key}', '{player_key}')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <type>add</type>
            <player>
              <player_key>{player_key}</player_key>
              <transaction_data>
                <type>add</type>
                <destination_team_key>{team_key}</destination_team_key>
              </transaction_data>
            </player>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end

  context 'drop request' do
    it 'should serialize correctly' do
      request = YahooFantasy::Resource::Transaction::AddDropAction.drop('{team_key}', '{player_key}')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <type>drop</type>
            <player>
              <player_key>{player_key}</player_key>
              <transaction_data>
                <type>drop</type>
                <source_team_key>{team_key}</source_team_key>
              </transaction_data>
            </player>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end

  context 'add/drop request' do
    it 'should serialize correctly' do
      request = YahooFantasy::Resource::Transaction::AddDropAction.add_drop('{team_key}', '{add_player_key}', '{drop_player_key}')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <type>add/drop</type>
            <players>
              <player>
                <player_key>{add_player_key}</player_key>
                <transaction_data>
                  <type>add</type>
                  <destination_team_key>{team_key}</destination_team_key>
                </transaction_data>
              </player>
              <player>
                <player_key>{drop_player_key}</player_key>
                <transaction_data>
                  <type>drop</type>
                  <source_team_key>{team_key}</source_team_key>
                </transaction_data>
              </player>
            </players>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end
end
