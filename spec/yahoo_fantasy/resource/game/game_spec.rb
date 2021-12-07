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

    it 'has five (5) filters' do
      expect(subject.filters.length).to eq(5)

      %i[game_keys is_available game_types game_codes seasons].each do |filter|
        expect(subject.filters.keys.include?(filter)).to eq(true), "expected #{filter} filter"
      end
    end
  end

  context '.all' do
    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should return YahooFantasy::Resource::Game::Games 371,406' do
      xml = File.read "#{__dir__}/../../xml/game/371_406.xml"
      response = Faraday::Response.new(status: 200, response_headers: {}, body: xml)

      allow(@access_token).to receive(:request).and_return(OAuth2::Response.new(response, parse: :yahoo_fantasy_content))

      YahooFantasy::Resource::Game::Game.access_token = @access_token

      games = YahooFantasy::Resource::Game::Game.all(game_keys: %w[371 406])

      expect(games.size).to be(2)
      expect(games[0].game_key).to eq('371')
      expect(games[1].game_key).to eq('406')
    end

    it 'should request /games;game_keys=371,406' do
      YahooFantasy::Resource::Game::Game.all(filters: { game_keys: %w[371 406] })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;game_keys=371,406', {})
    end

    it 'should request /games;is_available=1' do
      YahooFantasy::Resource::Game::Game.all(filters: { is_available: 1 })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;is_available=1', {})
    end

    it 'should request /games;game_types=full,pickem-team' do
      YahooFantasy::Resource::Game::Game.all(filters: { game_types: 'full,pickem-team' })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;game_types=full,pickem-team', {})
    end

    it 'should request /games;game_types=full,pickem-team' do
      YahooFantasy::Resource::Game::Game.all(filters: { game_types: %w[full pickem-team] })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;game_types=full,pickem-team', {})
    end

    it 'should request /games;game_codes=nfl' do
      YahooFantasy::Resource::Game::Game.all(filters: { game_codes: 'nfl' })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;game_codes=nfl', {})
    end

    it 'should request /games;game_codes=nfl' do
      YahooFantasy::Resource::Game::Game.all(filters: { game_codes: %w[nfl] })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;game_codes=nfl', {})
    end

    it 'should request /games;game_codes=nfl;out=leagues' do
      YahooFantasy::Resource::Game::Game.all(filters: { game_codes: %w[nfl] }, out: %w[leagues])
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/games;game_codes=nfl;out=leagues', {})
    end
  end

  context '.get' do
    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should return YahooFantasy::Resource::Game::Game' do
      xml = File.read "#{__dir__}/../../xml/game/406.xml"
      response = Faraday::Response.new(status: 200, response_headers: {}, body: xml)

      allow(@access_token).to receive(:request).and_return(OAuth2::Response.new(response, parse: :yahoo_fantasy_content))

      YahooFantasy::Resource::Game::Game.access_token = @access_token
      game = YahooFantasy::Resource::Game::Game.get(1)

      expect(game.class).to be(YahooFantasy::Resource::Game::Game)
      expect(game.game_key).to eq('406')
    end

    it 'should request /game/406' do
      YahooFantasy::Resource::Game::Game.get(406)
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/406', {})
    end

    it 'should request /game/406/out;leagues' do
      YahooFantasy::Resource::Game::Game.get(406, out: %w[leagues])
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/406;out=leagues', {})
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

    it 'should call /stat_categories' do
      subject.stat_categories!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/stat_categories', {})
    end

    it 'should call /stat_categories ignoring filters' do
      subject.stat_categories!(filters: { filter1: 'ignored' })
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

    it 'should call /position_types' do
      subject.position_types!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/position_types', {})
    end

    it 'should call /stat_categories ignoring filters' do
      subject.position_types!(filters: { filter1: 'ignored' })
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

    it 'should call /roster_positions' do
      subject.roster_positions!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/roster_positions', {})
    end

    it 'should call /roster_positions ignoring filters' do
      subject.roster_positions!(filters: { filter1: 'ignored' })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/roster_positions', {})
    end
  end
end
