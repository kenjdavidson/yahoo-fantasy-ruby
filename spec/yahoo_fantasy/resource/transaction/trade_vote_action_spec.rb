# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Transaction::TradeVoteAction do
  context '.accept' do
    # @type [YahooFantasy::Resource::Transaction::TradeVoteAction]
    subject { YahooFantasy::Resource::Transaction::TradeVoteAction }

    it 'responds to .accept' do
      expect(subject.respond_to?(:accept)).to eq(true)
    end

    it 'returns a TradeVoteAction accept request' do
      request = subject.accept('123.t.123', trade_note: 'I accept')

      expect(request.transaction_key).to eq('123.t.123')
      expect(request.type).to eq('pending_trade')
      expect(request.action).to eq('accept')
      expect(request.trade_note).to eq('I accept')
    end
  end

  context '.reject' do
    # @type [YahooFantasy::Resource::Transaction::TradeVoteAction]
    subject { YahooFantasy::Resource::Transaction::TradeVoteAction }

    it 'responds to .reject' do
      expect(subject.respond_to?(:reject)).to eq(true)
    end

    it 'returns a TradeVoteAction reject request' do
      request = subject.reject('123.t.123', trade_note: 'I reject')

      expect(request.transaction_key).to eq('123.t.123')
      expect(request.type).to eq('pending_trade')
      expect(request.action).to eq('reject')
      expect(request.trade_note).to eq('I reject')
    end
  end

  context '.allow' do
    # @type [YahooFantasy::Resource::Transaction::TradeVoteAction]
    subject { YahooFantasy::Resource::Transaction::TradeVoteAction }

    it 'responds to .allow' do
      expect(subject.respond_to?(:allow)).to eq(true)
    end

    it 'returns a TradeVoteAction allow request' do
      request = subject.allow('123.t.123')

      expect(request.transaction_key).to eq('123.t.123')
      expect(request.type).to eq('pending_trade')
      expect(request.action).to eq('allow')
      expect(request.trade_note).to eq(nil)
    end
  end

  context '.disallow' do
    # @type [YahooFantasy::Resource::Transaction::TradeVoteAction]
    subject { YahooFantasy::Resource::Transaction::TradeVoteAction }

    it 'responds to .disallow' do
      expect(subject.respond_to?(:disallow)).to eq(true)
    end

    it 'returns a TradeVoteAction disallow request' do
      request = subject.disallow('123.t.123')

      expect(request.transaction_key).to eq('123.t.123')
      expect(request.type).to eq('pending_trade')
      expect(request.action).to eq('disallow')
      expect(request.trade_note).to eq(nil)
    end
  end
end
