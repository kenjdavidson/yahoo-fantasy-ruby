# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Transaction::TradeActionRepresenter do
  subject { YahooFantasy::XML::Transaction::TradeActionRepresenter }

  context 'pending_trade request' do
    it 'should serialize correctly' do
      request = YahooFantasy::Resource::Transaction::TradeAction.pending_trade('{team1}', '{player1}', '{team2}', '{player2}')
      request.trade_note = 'Let me have em!'

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <type>pending_trade</type>
            <trader_team_key>{team1}</trader_team_key>
            <tradee_team_key>{team2}</tradee_team_key>
            <trade_note>Let me have em!</trade_note>
            <players>
              <player>
                <player_key>{player1}</player_key>
                <transaction_data>
                  <type>pending_trade</type>
                  <source_team_key>{team1}</source_team_key>
                  <destination_team_key>{team2}</destination_team_key>
                </transaction_data>
              </player>
              <player>
                <player_key>{player2}</player_key>
                <transaction_data>
                  <type>pending_trade</type>
                  <source_team_key>{team2}</source_team_key>
                  <destination_team_key>{team1}</destination_team_key>
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
