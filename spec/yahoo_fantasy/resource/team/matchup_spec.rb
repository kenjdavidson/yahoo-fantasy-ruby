# frozen_string_literal: true

RSpec.describe 'Matchup' do
  before do
    @winning_team = YahooFantasy::Resource::Team::Team.new(team_key: '406.l.117376.t.4')
    @winning_team_grade = 'A'
    @losing_team = YahooFantasy::Resource::Team::Team.new(team_key: '406.l.117376.t.5')
    @losing_team_grade = 'C'

    # @type
    @matchup = YahooFantasy::Resource::Team::Matchup.new do |m|
      m.week = 1
      m.week_start = '2021-07-07'
      m.week_end = '2021-07-14'
      m.status = 'postevent'
      m.is_playoffs = 0
      m.is_consolation = 0
      m.is_matchup_recap_available = 1
      m.is_tied = 0
      m.winner_team_key = '406.l.117376.t.4'
      m.teams = [@winning_team, @losing_team]
      m.matchup_grades = [@winning_team_grade, @losing_team_grade]
    end
  end

  context '#playoffs?' do
    it 'returns true when 1' do
      @matchup.is_playoffs = 1
      expect(@matchup.playoffs?).to eq(true)
    end

    it 'returns false when 0' do
      @matchup.is_playoffs = 0
      expect(@matchup.playoffs?).to eq(false)
    end

    it 'returns false when nil' do
      @matchup.is_playoffs = nil
      expect(@matchup.playoffs?).to eq(false)
    end
  end

  context '#consolation?' do
    it 'returns true when 1' do
      @matchup.is_consolation = 1
      expect(@matchup.consolation?).to eq(true)
    end

    it 'returns false when 0' do
      @matchup.is_consolation = 0
      expect(@matchup.consolation?).to eq(false)
    end

    it 'returns false when nil' do
      @matchup.is_consolation = nil
      expect(@matchup.consolation?).to eq(false)
    end
  end

  context '#winning_team' do
    it 'returns winning_team' do
      expect(@matchup.winning_team.team_key).to eq(@winning_team.team_key)
    end

    it 'returns nil' do
      @matchup.teams = []
      expect(@matchup.winning_team).to eq(nil)
    end

    it 'returns nil when no teams' do
      @matchup.teams = nil
      expect(@matchup.winning_team).to eq(nil)
    end
  end

  context '#losing_team' do
    it 'returns losing_team' do
      expect(@matchup.losing_team.team_key).to eq(@losing_team.team_key)
    end

    it 'returns nil' do
      @matchup.teams = []
      expect(@matchup.losing_team).to eq(nil)
    end

    it 'returns nil when no teams' do
      @matchup.teams = nil
      expect(@matchup.losing_team).to eq(nil)
    end
  end
end
