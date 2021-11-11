# frozen_string_literal: true

RSpec.describe YahooFantasy::Client do
  it 'creates urls with standard settings' do
    client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET')

    expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=oob&response_type=code&scope=fspt-w%2Cprofile%2Cemail'
    expect(client.auth_code.authorize_url).to eql(expected)
  end

  it 'creates authorize_url with custom redirect_uri' do
    client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET', redirect_uri: 'https://localhost:3000/auth/yahoo')

    # When Faraday builds the connection string, the parameters are put into alphabetical order
    expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=https%3A%2F%2Flocalhost%3A3000%2Fauth%2Fyahoo&response_type=code&scope=fspt-w%2Cprofile%2Cemail'
    expect(client.auth_code.authorize_url).to eql(expected)
  end

  it 'creates authorize_url with custom scope(s)' do
    # This wouldn't really help with getting User profile info, but it would allow sports
    client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET', scope: 'fspt-r')

    # When Faraday builds the connection string, the parameters are put into alphabetical order
    expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=oob&response_type=code&scope=fspt-r'
    expect(client.auth_code.authorize_url).to eql(expected)
  end

  it 'creates authorize_url with custom state' do
    # This wouldn't really help with getting User profile info, but it would allow sports
    client = YahooFantasy::Client.new('CLIENTID', 'CLIENTSECRET')

    # When Faraday builds the connection string, the parameters are put into alphabetical order
    expected = 'https://api.login.yahoo.com/oauth2/request_auth?client_id=CLIENTID&redirect_uri=oob&response_type=code&scope=fspt-w%2Cprofile%2Cemail&state=testing'
    expect(client.auth_code.authorize_url(state: 'testing')).to eql(expected)
  end
end
