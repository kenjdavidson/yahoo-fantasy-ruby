# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Game::GameRepresenter do
  context 'request contains out=game_weeks,position_types,roster_positions,stat_categories' do
    load_fantasy_content "#{__dir__}/game/406.xml"

    it 'should parse <fantasy_content>' do
      expect(fantasy_content.lang).to eq('en-US')
      expect(fantasy_content.uri).to eq('http://fantasysports.yahooapis.com/fantasy/v2/game/406;out=game_weeks,position_types,roster_positions,stat_categories')
      expect(fantasy_content.copyright).to eq('Data provided by Yahoo! and STATS, LLC')
      expect(fantasy_content.refresh_rate).to eq('60')
    end

    it 'should parse single <game>' do
      game = fantasy_content.game

      expect(game).not_to eq(nil)
      expect(game.game_key).to eq('406')
      expect(game.game_id).to eq(406)
      expect(game.name).to eq('Football')
      expect(game.type).to eq('full')
      expect(game.url).to eq('https://football.fantasysports.yahoo.com/f1')
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_game_over).to eq(0)
      expect(game.is_offseason).to eq(0)
    end

    it 'should parse <game_weeks>' do
      game_weeks = fantasy_content.game.game_weeks

      expect(game_weeks.count).to eq(18)
      expect(game_weeks[0].week).to eq(1)
      expect(game_weeks[0].display_name).to eq('1')
      expect(game_weeks[0].start).to eq('2021-09-09')
      expect(game_weeks[0].end).to eq('2021-09-13')
    end

    it 'should parse <roster_positions>' do
      roster_positions = fantasy_content.game.roster_positions

      expect(roster_positions.count).to eq(20)
      expect(roster_positions[0].position).to eq('QB')
      expect(roster_positions[0].abbreviation).to eq('QB')
      expect(roster_positions[0].display_name).to eq('Quarterback')
      expect(roster_positions[0].position_type).to eq('O')
    end

    it 'should parse <position_types>' do
      position_types = fantasy_content.game.position_types

      expect(position_types.count).to eq(4)
      expect(position_types[0].type).to eq('O')
      expect(position_types[0].display_name).to eq('Offense')
    end

    it 'should parse <stat_categories>' do
      stat_categories = fantasy_content.game.stat_categories

      expect(stat_categories.count).to eq(87)
      expect(stat_categories[0].stat_id).to eq(0)
      expect(stat_categories[0].name).to eq('Games Played')
      expect(stat_categories[0].display_name).to eq('GP')
      expect(stat_categories[0].sort_order).to eq(1)
      expect(stat_categories[0].position_types.count).to eq(4)
      expect(stat_categories[0].position_types[0]).to eq('O')
      expect(stat_categories[0].position_types[1]).to eq('DP')
      expect(stat_categories[0].position_types[2]).to eq('K')
      expect(stat_categories[0].position_types[3]).to eq('DT')
    end
  end
end
