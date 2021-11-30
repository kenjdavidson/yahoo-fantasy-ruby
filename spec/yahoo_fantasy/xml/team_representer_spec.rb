# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe YahooFantasy::XML::Team::TeamRepresenter do
  context 'request contains metadata' do
    load_fantasy_content "#{__dir__}/team/406.l.117376.t.4.xml"

    subject { fantasy_content.team }

    it 'should parse single <team>' do
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

  context 'request contains metadata' do
    load_fantasy_content "#{__dir__}/team/406.l.117376.t.4_roster.xml"

    subject { fantasy_content.team.roster }

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
    end
  end
end
