# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Transaction::WaiverActionRepresenter do
  subject { YahooFantasy::XML::Transaction::WaiverActionRepresenter }

  context 'priority request' do
    it 'should serialize correctly' do
      request = YahooFantasy::Resource::Transaction::WaiverAction.edit_priority('248.l.55438.w.c.2_6093', 1, 20)

      xml = subject.new(request).to_xml

      expected = <<~XML
        <?xml version='1.0'?>
        <fantasy_content>
          <transaction>
            <transaction_key>248.l.55438.w.c.2_6093</transaction_key>
            <type>waiver</type>
            <waiver_priority>1</waiver_priority>
            <faab_bid>20</faab_bid>
          </transaction>
        </fantasy_content>
      XML

      expect(xml).to eq(expected)
    end
  end
end
