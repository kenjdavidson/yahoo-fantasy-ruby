# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Transaction::TradeVoteActionRepresenter do
  subject { YahooFantasy::XML::Transaction::TradeVoteActionRepresenter }

  context 'accept request' do
    it 'should serialize with trade_note' do
      request = YahooFantasy::Resource::Transaction::TradeVoteAction.accept('248.l.55438.pt.11', trade_note: 'Dude, that is a totally fair trade.')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.pt.11</transaction_key>
            <type>pending_trade</type>
            <action>accept</action>
            <trade_note>Dude, that is a totally fair trade.</trade_note>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end

    it 'should serialize without trade_note' do
      request = YahooFantasy::Resource::Transaction::TradeVoteAction.accept('248.l.55438.pt.11')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.pt.11</transaction_key>
            <type>pending_trade</type>
            <action>accept</action>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end

  context 'reject request' do
    it 'should serialize with trade_note' do
      request = YahooFantasy::Resource::Transaction::TradeVoteAction.reject('248.l.55438.pt.11', trade_note: 'No way Jose!')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.pt.11</transaction_key>
            <type>pending_trade</type>
            <action>reject</action>
            <trade_note>No way Jose!</trade_note>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end

    it 'should serialize without trade_note' do
      request = YahooFantasy::Resource::Transaction::TradeVoteAction.reject('248.l.55438.pt.11')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.pt.11</transaction_key>
            <type>pending_trade</type>
            <action>reject</action>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end

  context 'allow trade request' do
    it 'should serialize' do
      request = YahooFantasy::Resource::Transaction::TradeVoteAction.allow('248.l.55438.pt.11')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.pt.11</transaction_key>
            <type>pending_trade</type>
            <action>allow</action>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end

  context 'disallow trade request' do
    it 'should serialize xml' do
      request = YahooFantasy::Resource::Transaction::TradeVoteAction.disallow('248.l.55438.pt.11')

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.pt.11</transaction_key>
            <type>pending_trade</type>
            <action>disallow</action>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end
end
