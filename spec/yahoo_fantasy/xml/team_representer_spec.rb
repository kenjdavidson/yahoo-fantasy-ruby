# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Team::TeamRepresenter do
  context 'request contains metadata' do
    load_fantasy_content "#{__dir__}/team/406.l.117376.t.4.xml"

    subject { fantasy_content.team }

    it 'should parse <team> metadata' do
      expect(subject).not_to eq(nil)
      expect(subject.team_key).to eq('406.l.117376.t.4')
      expect(subject.team_id).to eq(4)
      expect(subject.league_key).to eq('406.l.117376')
      expect(subject.league_id).to eq(117_376)
      expect(subject.game_key).to eq('406')
      expect(subject.game_id).to eq(406)
      expect(subject.name).to eq('Chalupa Batman')
      expect(subject.is_owned_by_current_login).to eq(1)
    end

    it 'should parse team logos' do
      expect(subject.team_logos).not_to eq(nil)
      expect(subject.team_logos.count).to eq(1)
      expect(subject.team_logos[0].image_size).to eq('large')
      expect(subject.team_logos[0].url).to eq('https://yahoofantasysports-res.cloudinary.com/image/upload/t_s192sq/fantasy-logos/25228801831_861d183f44.jpg')
    end

    it 'should parse team managers' do
      expect(subject.managers.count).to eq(1)
      expect(subject.managers[0].nickname).to eq('Kenneth')
      expect(subject.managers[0].guid).to eq('HJXEGSOPDMQLLZFJIQ2BCZA3Z4')
      expect(subject.managers[0].is_current_login).to eq(1)
      expect(subject.managers[0].image_url).to eq('https://s.yimg.com/ag/images/bb794a81-8eb6-4614-b0e4-2399e94a9a38_64sq.jpg')
      expect(subject.managers[0].felo_score).to eq(733)
      expect(subject.managers[0].felo_tier).to eq('gold')
    end

    it 'should parse roster adds' do
      expect(subject.roster_adds).not_to eq(nil)
      expect(subject.roster_adds.coverage_type).to eq('week')
      expect(subject.roster_adds.coverage_value).to eq(13)
      expect(subject.roster_adds.value).to eq(0)
    end

    it 'should parse points and projected points' do
      expect(subject.team_points).not_to eq(nil)
      expect(subject.team_points.coverage_type).to eq('week')
      expect(subject.team_points.week).to eq(12)
      expect(subject.team_points.total).to eq(128.70)
      expect(subject.team_projected_points).not_to eq(nil)
      expect(subject.team_projected_points.coverage_type).to eq('week')
      expect(subject.team_projected_points.week).to eq(12)
      expect(subject.team_projected_points.total).to eq(138.10)
    end
  end

  context 'request contains ;out=roster' do
    load_fantasy_content "#{__dir__}/team/406.l.117376.t.4_roster.xml"

    subject { fantasy_content.team.roster }

    it 'should have roster' do
      expect(subject).not_to eq(nil)
    end

    it 'should have coverage_type week' do
      expect(subject.coverage_type).to eq('week')
    end

    it 'should have week 13' do
      expect(subject.week).to eq(13)
    end

    it 'should be editable' do
      expect(subject.is_editable).to eq(1)
      expect(subject.editable?).to eq(true)
    end

    it 'should have correct players' do
      expect(subject.players.count).to eq(18)
      expect(subject.players[0].player_key).to eq('406.p.29369')
      expect(subject.players[0].player_id).to eq(29_369)
      expect(subject.players[0].name.full).to eq('Dak Prescott')
    end
  end

  context 'request contains ;out=matchup' do
    load_fantasy_content "#{__dir__}/team/406.l.117376.t.4_matchups.xml"

    subject { fantasy_content.team.matchups }

    it 'should have matchups' do
      expect(subject).not_to eq(nil)
      expect(subject.count).to eq(14)
    end

    it 'should have correct matchup[0]' do
      expect(subject[0].week).to eq(1)
      expect(subject[0].week_start).to eq('2021-09-09')
      expect(subject[0].week_end).to eq('2021-09-13')
      expect(subject[0].status).to eq('postevent')
      expect(subject[0].is_playoffs).to eq(0)
      expect(subject[0].is_consolation).to eq(0)
      expect(subject[0].is_matchup_recap_available).to eq(1)
    end

    it 'has matchup[0] grades' do
      expect(subject[0].matchup_grades).not_to eq(nil)
      expect(subject[0].matchup_grades.count).to eq(2)
      expect(subject[0].matchup_grades[0].team_key).to eq('406.l.117376.t.4')
      expect(subject[0].matchup_grades[0].grade).to eq('A')
      expect(subject[0].matchup_grades[1].team_key).to eq('406.l.117376.t.14')
      expect(subject[0].matchup_grades[1].grade).to eq('C')
    end
  end
end
