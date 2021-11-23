# frozen_string_literal: true

require 'yahoo_omniauth'

RSpec.describe OmniAuth::Strategies::YahooOAuth do
  def app
    lambda do |_env|
      [200, {}, ['Hello.']]
    end
  end

  def env
    {

    }
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  context 'Subclassing Behavior' do
    it 'performs the OmniAuth::Strategy included hook' do
      expect(OmniAuth.strategies).to include(OmniAuth::Strategies::YahooOAuth)
    end
  end

  context '#client' do
    subject { OmniAuth::Strategies::YahooOAuth }

    it 'is type YahooFantasy::Client' do
      instance = subject.new(app, 'client_id', 'client_secret')

      expect(instance.client.class).to eq(YahooFantasy::Client)
    end

    it 'initialize client with client_id and client_secret' do
      instance = subject.new(app, 'client_id', 'client_secret')

      expect(instance.client.id).to eq('client_id')
      expect(instance.client.secret).to eq('client_secret')
      expect(instance.client.options[:redirect_uri]).to eq('oob')
    end

    it 'initialize client with client_options' do
      instance = subject.new(app, 'client_id', 'client_secret',
                             client_options: { scope: 'fspt-r', redirect_uri: 'https://localhost' })

      expect(instance.client.options[:scope]).to eq('fspt-r')
      expect(instance.client.options[:redirect_uri]).to eq('https://localhost')
    end
  end

  context '#request_phase' do
    subject { OmniAuth::Strategies::YahooOAuth }

    it 'calls app when redirect_uri is oob' do
      instance = subject.new(app, 'client_id', 'client_secret')
    end

    it 'calls super when redirect_uri is not oob' do
      instance = subject.new(app, 'client_id', 'client_secret',
                             client_options: { redirect_uri: 'https://localhost' })
    end
  end
end
