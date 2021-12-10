# frozen_string_literal: true

require 'oauth2'

RSpec.describe YahooFantasy::Resource::User::User do
  context 'class definition' do
    subject { YahooFantasy::Resource::User::User }

    it 'has two subresources' do
      expect(subject.subresources.count).to eq(2)
    end

    it 'has profile subresource' do
      expect(subject.subresources.keys.include?(:profile)).to eq(true)
    end

    it 'has games subresource' do
      expect(subject.subresources.keys.include?(:games)).to eq(true)
    end
  end

  context '.collection_path' do
    it 'should be /users;use_login=1' do
      expect(YahooFantasy::Resource::User::User.collection_path).to eq('/users;use_login=1')
    end
  end

  context '.resource_path' do
    it 'should be /users;use_login=1' do
      expect(YahooFantasy::Resource::User::User.resource_path).to eq('/users;use_login=1')
    end
  end

  context '.all' do
    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should request ;out=profile' do
      YahooFantasy::Resource::User::User.all(out: 'profile')
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1;out=profile', {})
    end

    it 'should request ;out=games' do
      YahooFantasy::Resource::User::User.all(out: 'games')
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1;out=games', {})
    end

    it 'should request /games/leagues' do
      YahooFantasy::Resource::User::User.all(query: '/games/leagues')
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games/leagues', {})
    end
  end
end
