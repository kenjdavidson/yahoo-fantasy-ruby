# frozen_string_literal: true

RSpec.describe YahooFantasy::Client do
  context 'simple configuration' do
    before(:each) do
      @client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET')
    end

    it 'sets #id' do
      expect(@client.id).to eq('CLIENTID')
    end

    it 'sets #secret' do
      expect(@client.secret).to eq('CLIENTSECRET')
    end

    it 'sets #site' do
      expect(@client.site).to eq(YahooFantasy::Client::SITE)
    end

    it 'sets options[authorize_url]' do
      expect(@client.options[:authorize_url]).to eq(YahooFantasy::Client::AUTHORIZE_URL)
    end

    it 'sets options[token_url]' do
      expect(@client.options[:token_url]).to eq(YahooFantasy::Client::TOKEN_URL)
    end

    it 'sets options[scope]' do
      expect(@client.options[:scope]).to eq(YahooFantasy::Client::WRITE_SCOPE)
    end

    it 'sets options[redirect_uri]' do
      expect(@client.options[:redirect_uri]).to eq(YahooFantasy::Client::OOB)
    end
  end

  context 'customized configuration' do
    before(:each) do
      @options = {
        redirect_uri: 'http://localhost.dev',
        scope: YahooFantasy::Client::READ_SCOPE
      }
      @client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET', @options)
    end

    it 'sets #id' do
      expect(@client.id).to eq('CLIENTID')
    end

    it 'sets #secret' do
      expect(@client.secret).to eq('CLIENTSECRET')
    end

    it 'sets #site' do
      expect(@client.site).to eq(YahooFantasy::Client::SITE)
    end

    it 'sets options[authorize_url]' do
      expect(@client.options[:authorize_url]).to eq(YahooFantasy::Client::AUTHORIZE_URL)
    end

    it 'sets options[token_url]' do
      expect(@client.options[:token_url]).to eq(YahooFantasy::Client::TOKEN_URL)
    end

    it 'sets custom options[scope]' do
      expect(@client.options[:scope]).to eq(@options[:scope])
    end

    it 'sets custom options[redirect_uri]' do
      expect(@client.options[:redirect_uri]).to eq(@options[:redirect_uri])
    end
  end

  context '#authorize_url' do
    it 'creates authorize_url standard configuration' do
      # This wouldn't really help with getting User profile info, but it would allow sports
      client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET')

      # When Faraday builds the connection string, the parameters are put into alphabetical order
      expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=oob&response_type=code&scope=fspt-w'
      expect(client.auth_code.authorize_url).to eql(expected)
    end

    it 'creates authorize_url with custom scope(s)' do
      # This wouldn't really help with getting User profile info, but it would allow sports
      client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET', scope: YahooFantasy::Client::READ_SCOPE)

      # When Faraday builds the connection string, the parameters are put into alphabetical order
      expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=oob&response_type=code&scope=fspt-r'
      expect(client.auth_code.authorize_url).to eql(expected)
    end

    it 'creates authorize_url with custom state' do
      # This wouldn't really help with getting User profile info, but it would allow sports
      client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET')

      # When Faraday builds the connection string, the parameters are put into alphabetical order
      expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=oob&response_type=code&scope=fspt-w&state=testing'
      expect(client.auth_code.authorize_url(state: 'testing')).to eql(expected)
    end

    it 'creates authorize_url with custom redirect_uri' do
      redirect_uri = 'https://localhost:3000/auth/yahoo'
      client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET', redirect_uri: redirect_uri)

      # When Faraday builds the connection string, the parameters are put into alphabetical order
      expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=https%3A%2F%2Flocalhost%3A3000%2Fauth%2Fyahoo&response_type=code&scope=fspt-w'
      expect(client.auth_code.authorize_url).to eql(expected)
    end
  end

  context '#request' do
    before(:each) do
      @client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET')
    end

    it 'raises error on 401 unauthorized request' do
      url = 'http://yahoo-fantasy-test'
      body = File.read("#{__dir__}/xml/401.xml")
      response = double('Faraday::Response',
                        status: 401,
                        headers: {},
                        body: body)
      connection = double('Faraday::Connection',
                          build_url: url,
                          run_request: response)

      @client.connection = connection

      expect { @client.request(:get, url) }.to raise_error(OAuth2::Error)
    end
  end
end
