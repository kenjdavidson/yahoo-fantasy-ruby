# frozen_string_literal: true

require 'oauth2'

RSpec.describe YahooFantasy::Resource::Game::Game do
  context 'class definition' do
    subject { YahooFantasy::Resource::Game::Game.new }

    it 'has all accessors' do
      %i[game_key game_id name code type url season is_registration_over is_game_over is_offseason].each do |a|
        expect(subject.respond_to?(a)).to eql(true), "expect respond to #{a}"
        expect(subject.respond_to?("#{a}=")).to eql(true), "expect respond to #{a}="
      end
    end
  end

  context 'subresource definition(s)' do
    subject { YahooFantasy::Resource::Game::Game }
    let(:game) { YahooFantasy::Resource::Game::Game.new }

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
        expect(subject.subresources[sub[0]]).to eq(sub[1]), "expected #{sub[0]} subresource to be #{sub[1].class}"
      end
    end

    it 'responds to subresource accessors' do
      [
        [:leagues, YahooFantasy::Resource::League::League],
        [:game_weeks, YahooFantasy::Resource::Game::GameWeek],
        [:roster_positions, YahooFantasy::Resource::Game::RosterPosition],
        [:stat_categories, YahooFantasy::Resource::Game::Statistic],
        [:position_types, YahooFantasy::Resource::Game::PositionType]
      ].each do |sub|
        expect(game.respond_to?(sub[0].to_s)).to eq(true), "expected respond to ##{sub[0]}"
        expect(game.respond_to?("#{sub[0]}=")).to eq(true), "expected respond to ##{sub[0]}="
        expect(game.respond_to?("#{sub[0]}!")).to eq(true), "expected respond to ##{sub[0]}!"
      end
    end
  end

  context 'filter definition(s)' do
    subject { YahooFantasy::Resource::Game::Game }

    it 'has four (4) filters' do
      expect(subject.filters.length).to eq 4

      %i[is_available game_types game_codes seasons].each do |filter|
        expect(subject.filters.keys.include?(filter)).to eq(true), "expected #{filter} filter"
      end
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

  context '#game_weeks!' do
    subject { YahooFantasy::Resource::Game::Game.new(game_key: '404', game_id: 404, code: 'nfl') }

    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it '#game_weeks! should call /game_weeks' do
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

    it '#roster_positions! should call /roster_positions' do
      subject.roster_positions!
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/game/404/roster_positions', {})
    end
  end
end
