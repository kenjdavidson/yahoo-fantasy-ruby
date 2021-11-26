# frozen_string_literal: true

require 'oauth2'

RSpec.describe YahooFantasy::Resource::Game::Game do
  context 'class definition' do
    subject { YahooFantasy::Resource::Game::Game }

    it 'has all accessors' do
      @game = subject.new
      %i[game_key game_id name code type url season is_registration_over is_game_over is_offseason].each do |a|
        expect(@game.respond_to?(a)).to eql(true), "expect respond to #{a}"
        expect(@game.respond_to?("#{a}=")).to eql(true), "expect respond to #{a}="
      end
    end

    it 'has five (5) subresources' do
      expect(subject.subresources.length).to eq 5

      [
        [:leagues, YahooFantasy::Resource::League::League],
        [:game_weeks, YahooFantasy::Resource::Game::GameWeek],
        [:roster_positions, YahooFantasy::Resource::Game::RosterPosition],
        [:stat_categories, YahooFantasy::Resource::Game::Statistic],
        [:position_types, YahooFantasy::Resource::Game::PositionType]
      ].each do |sub|
        expect(subject.subresources.keys.include?(sub[0])).to eq(true), "expected #{sub[0]} subresource"
      end
    end

    it 'has four (4) filters' do
      expect(subject.filters.length).to eq 4

      %i[is_available game_types game_codes seasons].each do |filter|
        expect(subject.filters.keys.include?(filter)).to eq(true), "expected #{filter} filter"
      end
    end
  end

  context '.all' do
    it 'should return YahooFantasy::Resource::Game::Games 371,406' do
      xml = File.read "#{__dir__}/../../xml/game/fantasy_content_games_371_406.xml"
      response = Faraday::Response.new(status: 200, response_headers: {}, body: xml)

      access_token = double(OAuth2::AccessToken)
      allow(access_token).to receive(:request).and_return(OAuth2::Response.new(response, parse: :yahoo_fantasy_content))

      YahooFantasy::Resource::Game::Game.access_token = access_token

      games = YahooFantasy::Resource::Game::Game.all(game_keys: %w[371 406])

      expect(games.size).to be(2)
      expect(games[0].game_key).to eq('371')
      expect(games[1].game_key).to eq('406')
    end
  end

  context '.get' do
    it 'should return YahooFantasy::Resource::Game::Game' do
      xml = File.read "#{__dir__}/../../xml/game/fantasy_content_game.xml"
      response = Faraday::Response.new(status: 200, response_headers: {}, body: xml)

      access_token = double(OAuth2::AccessToken)
      allow(access_token).to receive(:request).and_return(OAuth2::Response.new(response, parse: :yahoo_fantasy_content))

      YahooFantasy::Resource::Game::Game.access_token = access_token
      game = YahooFantasy::Resource::Game::Game.get(1)

      expect(game.class).to be(YahooFantasy::Resource::Game::Game)
      expect(game.game_key).to eq('406')
    end
  end

  context '#initialize' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    it 'should set game_key' do
      expect(subject.game_key).to eq('404')
    end

    it 'should set game_id' do
      expect(subject.game_id).to eq(404)
    end

    it 'should set code' do
      expect(subject.code).to eq('nfl')
    end
  end

  context '#resource_path' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    it 'should be correct' do
      expect(subject.resource_path).to eq('/game/404')
    end
  end

  context 'subresource game_weeks' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should respond_to accessor methods' do
      ['game_weeks', 'game_weeks=', 'game_weeks!'].each do |m|
        expect(subject.respond_to?(m)).to eq(true), "expected respond to ##{m}"
      end
    end

    it 'should call /game_weeks' do
      subject.game_weeks!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/game_weeks', {})
    end
  end

  context '#stat_categories!' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should respond_to accessor methods' do
      ['stat_categories', 'stat_categories=', 'stat_categories!'].each do |m|
        expect(subject.respond_to?(m)).to eq(true), "expected respond to ##{m}"
      end
    end

    it '#stat_categories! should call /stat_categories' do
      subject.stat_categories!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/stat_categories', {})
    end
  end

  context '#position_types!' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should respond_to accessor methods' do
      ['position_types', 'position_types=', 'position_types!'].each do |m|
        expect(subject.respond_to?(m)).to eq(true), "expected respond to ##{m}"
      end
    end

    it '#position_types! should call /position_types' do
      subject.position_types!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/position_types', {})
    end
  end

  context '#roster_positions!' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should respond_to accessor methods' do
      ['roster_positions', 'roster_positions=', 'roster_positions!'].each do |m|
        expect(subject.respond_to?(m)).to eq(true), "expected respond to ##{m}"
      end
    end

    it '#roster_positions! should call /roster_positions' do
      subject.roster_positions!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/roster_positions', {})
    end
  end
end
