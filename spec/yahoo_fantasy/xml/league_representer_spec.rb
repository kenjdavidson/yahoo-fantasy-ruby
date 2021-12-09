# frozen_string_literal: true

# @todo update all these specs so that the expected values are pulled from the xml.css('xpath')
#   to make testing a little more dynamic (and also allow for multiple xml files that generate)
#   tests automatically.
#
RSpec.describe YahooFantasy::XML::League::LeagueRepresenter do
  context 'request contains out=settings' do
    load_fantasy_content "#{__dir__}/league/406.l.117376.xml"

    before(:example) do
      access_token = double('access_token', request: {})
      YahooFantasy::Resource::Base.access_token = access_token
    end

    it 'should parse <fantasy_content>' do
      expect(fantasy_content.lang).to eq('en-US')
      expect(fantasy_content.uri).to eq('http://fantasysports.yahooapis.com/fantasy/v2/league/406.l.117376;out=settings,standings,scoreboard')
      expect(fantasy_content.copyright).to eq('Data provided by Yahoo! and STATS, LLC')
      expect(fantasy_content.refresh_rate).to eq('60')
    end

    it 'should parse <league> meta' do
      league = fantasy_content.league

      expect(league).not_to eq(nil)
      expect(league.league_key).to eq('406.l.117376')
      expect(league.name).to eq('MCS Fantasy Football 2021')
      expect(league.url).to eq('https://football.fantasysports.yahoo.com/f1/117376')
      expect(league.logo_url).to eq('')
      expect(league.draft_status).to eq('postdraft')
      expect(league.num_teams).to eq(16)
      expect(league.edit_key).to eq(10)
      expect(league.weekly_deadline).to eq(nil)
      expect(league.league_update_timestamp).to eq(1_636_617_048)
      expect(league.scoring_type).to eq('head')
      expect(league.league_type).to eq('private')
      expect(league.renew).to eq('399_38221')
      expect(league.renewed).to eq('')
      expect(league.iris_group_chat_id).to eq('')
      expect(league.allow_add_to_dl_extra_pos).to eq(1)
      expect(league.is_pro_league).to eq(0)
      expect(league.is_cash_league).to eq(0)
      expect(league.current_week).to eq(10)
      expect(league.start_week).to eq(1)
      expect(league.start_date).to eq('2021-09-09')
      expect(league.end_week).to eq(17)
      expect(league.end_date).to eq('2022-01-03')
      expect(league.game_code).to eq('nfl')
      expect(league.season).to eq(2021)
    end

    it 'should parse <settings>' do
      settings = fantasy_content.league.settings

      expect(settings).not_to eq(nil)
      expect(settings.draft_type).to eq('live')
      expect(settings.is_auction_draft).to eq(0)
      expect(settings.scoring_type).to eq('head')
      expect(settings.uses_playoff).to eq(1)
      expect(settings.has_playoff_consolation_games).to eq(1)
      expect(settings.playoff_start_week).to eq(15)
      expect(settings.uses_playoff_reseeding).to eq(0)
      expect(settings.uses_lock_eliminated_teams).to eq(1)
      expect(settings.num_playoff_teams).to eq(8)
      expect(settings.num_playoff_consolation_teams).to eq(0)
      expect(settings.has_multiweek_championship).to eq(0)
      expect(settings.uses_roster_import).to eq(1)
      expect(settings.roster_import_deadline).to eq('2021-08-22')
      expect(settings.waiver_type).to eq('R')
      expect(settings.waiver_rule).to eq('gametime')
      expect(settings.uses_faab).to eq(0)
      expect(settings.draft_time).to eq(1_630_285_200)
      expect(settings.draft_pick_time).to eq(45)
      expect(settings.post_draft_players).to eq('FA')
      expect(settings.max_teams).to eq(16)
      expect(settings.waiver_time).to eq(1)
      expect(settings.trade_end_date).to eq('2021-11-13')
      expect(settings.trade_ratify_type).to eq('commish')
      expect(settings.trade_reject_time).to eq(1)
      expect(settings.player_pool).to eq('ALL')
      expect(settings.cant_cut_list).to eq('none')
      expect(settings.draft_together).to eq(0)
      expect(settings.can_trade_draft_picks).to eq(1)
      expect(settings.sendbird_channel_url).to eq('a0ee24315cd7b09a0c8a7fd194bcd3a0')
      expect(settings.max_weekly_adds).to eq(4)
      expect(settings.pickem_enabled).to eq(0)
      expect(settings.uses_fractional_points).to eq(1)
      expect(settings.uses_negative_points).to eq(1)
    end

    it 'should parse <settings>/<roster_positions>' do
      roster_positions = fantasy_content.league.settings.roster_positions

      expect(roster_positions).not_to eq(nil)
      expect(roster_positions.count).to eq(10)
      expect(roster_positions[0].position).to eq('QB')
      expect(roster_positions[0].position_type).to eq('O')
      expect(roster_positions[0].count).to eq(1)
      expect(roster_positions[0].is_starting_position).to eq(1)
    end

    it 'should parse <settings>/<stat_categories>' do
      stat_categories = fantasy_content.league.settings.stat_categories

      expect(stat_categories).not_to eq(nil)
      expect(stat_categories.count).to eq(47)
      expect(stat_categories[0].stat_id).to eq(4)
      expect(stat_categories[0].enabled).to eq(1)
      expect(stat_categories[0].name).to eq('Passing Yards')
      expect(stat_categories[0].display_name).to eq('Pass Yds')
      expect(stat_categories[0].sort_order).to eq(1)
      expect(stat_categories[0].position_type).to eq('O')
      expect(stat_categories[0].stat_position_types[0].position_type).to eq('O')
    end

    it 'should parse <settings>/<stat_modifiers>' do
      stat_modifiers = fantasy_content.league.settings.stat_modifiers

      expect(stat_modifiers).not_to eq(nil)
      expect(stat_modifiers.count).to eq(44)
      expect(stat_modifiers[0].stat_id).to eq(4)
      expect(stat_modifiers[0].value).to eq(0.04)
    end
  end

  context 'request contains out=settings' do
    load_fantasy_content "#{__dir__}/league/406.l.117376_standings.xml"

    it 'should parse <standings>' do
      standings = fantasy_content.league.standings

      expect(standings).not_to eq(nil)
      expect(standings.count).to eq(16)
      expect(standings[0].team_key).to eq('406.l.117376.t.2')
      expect(standings[0].team_id).to eq(2)
      expect(standings[0].name).to eq('Action Jackson')
      expect(standings[0].url).to eq('https://football.fantasysports.yahoo.com/f1/117376/2')
      expect(standings[0].team_logos.count).to eq(1)
      expect(standings[0].waiver_priority).to eq(2)
      expect(standings[0].number_of_moves).to eq(29)
      expect(standings[0].number_of_trades).to eq(5)
      expect(standings[0].clinched_playoffs).to eq(1)
      expect(standings[0].league_scoring_type).to eq('head')
      expect(standings[0].managers.count).to eq(1)
      expect(standings[0].team_points).not_to eq(nil)
      expect(standings[0].team_points.coverage_type).to eq('season')
      expect(standings[0].team_points.season).to eq(2021)
      expect(standings[0].team_points.total).to eq(1646.56)
      expect(standings[0].standings.rank).to eq(1)
      expect(standings[0].standings.playoff_seed).to eq(1)
      expect(standings[0].standings.wins).to eq(9)
      expect(standings[0].standings.losses).to eq(3)
      expect(standings[0].standings.ties).to eq(0)
      expect(standings[0].standings.percentage).to eq(0.750)
      expect(standings[0].standings.streak_type).to eq('win')
      expect(standings[0].standings.streak_value).to eq(4)
      expect(standings[0].standings.points_for).to eq(1646.56)
      expect(standings[0].standings.points_against).to eq(1444.52)
    end
  end

  context 'request contains out=draftresults' do
    load_fantasy_content "#{__dir__}/league/406.l.117376_draftresults.xml"

    it 'should parse <draftresults>' do
      draft_results = fantasy_content.league.draft_results

      expect(draft_results).not_to eq(nil)
      expect(draft_results.count).to eq(256)
      expect(draft_results[0].pick).to eq(1)
      expect(draft_results[0].round).to eq(1)
      expect(draft_results[0].team_key).to eq('406.l.117376.t.12')
      expect(draft_results[0].player_key).to eq('406.p.32736')
    end

    it 'should parse <draftresults>/<player>' do
      draft_results = fantasy_content.league.draft_results
      player = draft_results[0].player

      expect(player).not_to eq(nil)
      expect(player.player_key).to eq('406.p.32736')
    end
  end
end
