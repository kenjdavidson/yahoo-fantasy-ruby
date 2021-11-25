# frozen_string_literal: true

require 'oauth2'

RSpec.describe YahooFantasy::Resource::Base do
  after(:each) do
    YahooFantasy::Resource::Base.access_token = nil
  end

  context 'access_token definition' do
    it 'should respond negatively to #access_token method' do
      expect(YahooFantasy::Resource::Base.access_token).to eq(nil)
    end

    it 'should respond negatively to #access_token?' do
      expect(YahooFantasy::Resource::Base.access_token?).to eq(false)
    end
  end

  context 'multiple threads configured with tokens' do
    it 'access_token(s) should not be maintained separately' do
      access_token1 = double
      allow(access_token1).to receive(:request)

      access_token2 = double
      allow(access_token2).to receive(:request)

      thread1 = Thread.new do
        YahooFantasy::Resource::Base.access_token = access_token1
        expect(YahooFantasy::Resource::Base.access_token?).to eq(true)
        expect(YahooFantasy::Resource::Base.access_token).to eq(access_token1)
      end

      thread2 = Thread.new do
        YahooFantasy::Resource::Base.access_token = access_token2
        expect(YahooFantasy::Resource::Base.access_token?).to eq(true)
        expect(YahooFantasy::Resource::Base.access_token).to eq(access_token2)
      end

      thread1.join
      thread2.join
    end
  end

  context '.build_uri' do
    it 'should prefix path with base_endpoint' do
      expect(YahooFantasy::Resource::Base.build_uri('/games')).to eq('https://fantasysports.yahooapis.com/fantasy/v2/games')
    end

    it 'shouldn not prefix path with base_endpoint when full uri' do
      expect(YahooFantasy::Resource::Base.build_uri('https://yahoofantasy.com/games')).to eq('https://yahoofantasy.com/games')
    end
  end

  context '.api' do
    it 'raises YahooFantasy::MissingAccessTokenError when no AccessToken' do
      # expect { raise YahooFantasy::MissingAccessTokenError }.to raise_error(YahooFantasy::MissingAccessTokenError)
      expect { YahooFantasy::Resource::Base.api(:get, '/games') }.to raise_error(YahooFantasy::MissingAccessTokenError)
    end

    it 'should call OAuth2::AccessToken#request method for GET /path with no options' do
      access_token = spy(OAuth2::AccessToken)

      YahooFantasy::Resource::Base.access_token = access_token
      YahooFantasy::Resource::Base.api(:get, '/path')

      expect(access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/path', {})
    end
  end

  context '.resource_prefix' do
    before do
      test_resource = Class.new(YahooFantasy::Resource::Base)
      stub_const('TestResource', test_resource)
    end
    it 'should return snake downcase class name' do
      expect(TestResource.resource_prefix).to eq('/test_resource')
    end
  end

  context '#api' do
    it 'raises YahooFantasy::MissingAccessTokenError when no AccessToken' do
      # expect { raise YahooFantasy::MissingAccessTokenError }.to raise_error(YahooFantasy::MissingAccessTokenError)
      expect { subject.class.api(:get, '/games') }.to raise_error(YahooFantasy::MissingAccessTokenError)
    end
  end
end
