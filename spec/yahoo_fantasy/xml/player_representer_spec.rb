# frozen_string_literal: true

# @todo update all these specs so that the expected values are pulled from the xml.css('xpath')
#   to make testing a little more dynamic (and also allow for multiple xml files that generate)
#   tests automatically.
#
RSpec.describe YahooFantasy::XML::Player::PlayerRepresenter do
  context 'request /player;out=meta or /player' do
    load_fantasy_content "#{__dir__}/player/406.p.31883.xml"

    before(:example) do
      access_token = double('access_token', request: {})
      YahooFantasy::Resource::Base.access_token = access_token
    end

    it 'should parse <player> meta' do
      player = fantasy_content.player

      expect(player).not_to eq(nil)
      expect(player.player_key).to eq('406.p.31883')
      expect(player.player_id).to eq(31_883)
      expect(player.status).to eq('IR')
      expect(player.status_full).to eq('Injured Reserve')
      expect(player.injury_note).to eq('Chest')
      expect(player.uniform_number).to eq(11)
      expect(player.display_position).to eq('WR')
      expect(player.image_url).to eq('https://s.yimg.com/iu/api/res/1.2/pBwFyor5nOE.Pt.WhVxVKQ--~C/YXBwaWQ9eXNwb3J0cztjaD0yMzM2O2NyPTE7Y3c9MTc5MDtkeD04NTc7ZHk9MDtmaT11bGNyb3A7aD02MDtxPTEwMDt3PTQ2/https://s.yimg.com/xe/i/us/sp/v/nfl_cutout/players_l/08292021/31883.png')
      expect(player.is_undroppable).to eq(0)
    end

    it 'should parse <player> name' do
      player_name = fantasy_content.player.name

      expect(player_name).not_to eq(nil)
      expect(player_name.first).to eq('A.J.')
      expect(player_name.last).to eq('Brown')
      expect(player_name.ascii_first).to eq('A.J.')
      expect(player_name.ascii_last).to eq('Brown')
    end

    it 'should parse <player> editorials' do
      player = fantasy_content.player

      expect(player.editorial_player_key).to eq('nfl.p.31883')
      expect(player.editorial_team_key).to eq('nfl.t.10')
      expect(player.editorial_team_full_name).to eq('Tennessee Titans')
      expect(player.editorial_team_abbr).to eq('Ten')
    end

    it 'should parse bye weeks' do
      player = fantasy_content.player

      expect(player.bye_weeks.count).to eq(1)
      expect(player.bye_weeks[0]).to eq(13)
    end

    it 'should parse headshot' do
      player = fantasy_content.player

      expect(player.headshot.url).to eq('https://s.yimg.com/iu/api/res/1.2/pBwFyor5nOE.Pt.WhVxVKQ--~C/YXBwaWQ9eXNwb3J0cztjaD0yMzM2O2NyPTE7Y3c9MTc5MDtkeD04NTc7ZHk9MDtmaT11bGNyb3A7aD02MDtxPTEwMDt3PTQ2/https://s.yimg.com/xe/i/us/sp/v/nfl_cutout/players_l/08292021/31883.png')
      expect(player.headshot.size).to eq('small')
    end

    it 'should parse eligible positions' do
      player = fantasy_content.player

      expect(player.eligible_positions.count).to eq(1)
      expect(player.eligible_positions[0]).to eq('WR')
    end
  end

  context 'request /player/stats' do
    load_fantasy_content "#{__dir__}/player/406.p.31883_stats.xml"

    before(:example) do
      access_token = double('access_token', request: {})
      YahooFantasy::Resource::Base.access_token = access_token
    end

    it 'should parse player_stats' do
      player_stats = fantasy_content.player.player_stats

      expect(player_stats).not_to eq(nil)
      expect(player_stats.coverage_type).to eq('season')
      expect(player_stats.season).to eq(2021)
      expect(player_stats.date).to eq(nil)
      expect(player_stats.week).to eq(nil)
      expect(player_stats.stats.count).to eq(31)
      expect(player_stats.stats[0].stat_id).to eq(0)
      expect(player_stats.stats[0].value).to eq(10)
    end

    it 'should parse advanced_player_stats' do
      player_stats = fantasy_content.player.player_advanced_stats

      expect(player_stats).not_to eq(nil)
      expect(player_stats.coverage_type).to eq('season')
      expect(player_stats.season).to eq(2021)
      expect(player_stats.date).to eq(nil)
      expect(player_stats.week).to eq(nil)
      expect(player_stats.stats.count).to eq(13)
      expect(player_stats.stats[0].stat_id).to eq(1001)
      expect(player_stats.stats[0].value).to eq(0)
    end
  end
end
