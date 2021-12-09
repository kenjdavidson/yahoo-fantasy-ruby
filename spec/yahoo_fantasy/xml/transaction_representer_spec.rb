# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe 'TransactionRepresenter' do
  context '/transactions' do
    load_fantasy_content "#{__dir__}/transaction/406.l.117376.tr.584.xml"

    subject { fantasy_content.transactions }

    it 'should have 1 transaction' do
      expect(subject.count).to eq(1)
    end

    it 'should parse correctly' do
      transaction = subject[0]

      expect(transaction.transaction_key).to eq('406.l.117376.tr.584')
      expect(transaction.transaction_id).to eq(584)
      expect(transaction.type).to eq('add/drop')
      expect(transaction.status).to eq('successful')
      expect(transaction.timestamp).to eq(1_638_224_605)
    end

    it 'should parse players' do
      transaction = subject[0]

      expect(transaction.players.count).to eq(2)
      expect(transaction.players[0].player_key).to eq('406.p.32814')
      expect(transaction.players[1].player_key).to eq('406.p.32608')
    end

    it 'should parse players[0]' do
      transaction = subject[0]

      expect(transaction.players[0].player_key).to eq('406.p.32814')
      expect(transaction.players[0].player_id).to eq(32_814)
      expect(transaction.players[0].name.full).to eq('DeeJay Dallas')
    end

    it 'should parse players[1]' do
      transaction = subject[0]

      expect(transaction.players[1].player_key).to eq('406.p.32608')
      expect(transaction.players[1].player_id).to eq(32_608)
      expect(transaction.players[1].name.full).to eq('D\'Ernest Johnson')
    end
  end
end
