# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::League::League do
  subject { YahooFantasy::Resource::League::League }

  context 'class definition' do
    it 'has all accessors' do
      @league = YahooFantasy::Resource::League::League.new

      %i[
        league_key league_id name url logo_url draft_status num_teams edit_key weekly_deadline
        league_update_timestamp scoring_type league_type renew renewed iris_group_chat_id allow_add_to_dl_extra_pos
        is_pro_league is_cash_league current_week start_week start_date end_week end_date game_code season
      ].each do |a|
        expect(@league.respond_to?(a)).to eql(true), "expect respond to #{a}"
        expect(@league.respond_to?("#{a}=")).to eql(true), "expect respond to #{a}="
      end
    end

    it 'has four (4) subresources' do
      expect(YahooFantasy::Resource::League::League.subresources.length).to eq 4

      [
        [:settings, YahooFantasy::Resource::League::Settings],
        [:standings, YahooFantasy::Resource::Team::Team],
        [:scoreboard, YahooFantasy::Resource::League::Scoreboard],
        [:teams, YahooFantasy::Resource::Team::Team]
        # [:players, YahooFantasy::Resource::Player],
        # [:draft_results, YahooFantasy::Resource::League::DraftResults],
        # [:transactions, YahooFantasy::Resource::League::Transation]
      ].each do |sub|
        expect(YahooFantasy::Resource::League::League.subresources.keys.include?(sub[0])).to eq(true), "expected #{sub[0]} subresource"
      end
    end

    it 'has four (1) filters' do
      expect(YahooFantasy::Resource::League::League.filters.length).to eq 1

      %i[league_keys].each do |filter|
        expect(subject.filters.keys.include?(filter)).to eq(true), "expected #{filter} filter"
      end
    end
  end

  context '#initialize' do
    subject { YahooFantasy::Resource::League::League.new(league_key: '404.l.12345', league_id: 12_345, name: 'NFL Football League') }

    it 'should set league_key' do
      expect(subject.league_key).to eq('404.l.12345')
    end

    it 'should set league_id' do
      expect(subject.league_id).to eq(12_345)
    end

    it 'should set name' do
      expect(subject.name).to eq('NFL Football League')
    end

    it 'should parse game_key' do
      expect(subject.game_key).to eq('404')
    end

    it 'should parse game_id' do
      expect(subject.game_id).to eq(404)
    end
  end

  context '#resource_path' do
    subject { YahooFantasy::Resource::League::League.new(league_key: '404.l.12345', league_id: 12_345, name: 'NFL Football League') }

    it 'should be correct' do
      expect(subject.resource_path).to eq('/league/404.l.12345')
    end
  end

  context '.all' do
    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should request /leagues;league_keys=406.l.12345' do
      YahooFantasy::Resource::League::League.all(filters: { league_keys: %w[406.l.12345] })
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/leagues;league_keys=406.l.12345', {})
    end

    it 'should request /leagues;league_keys=406.l.12345;out=standings' do
      YahooFantasy::Resource::League::League.all(filters: { league_keys: %w[406.l.12345] }, out: %w[standings])
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/leagues;league_keys=406.l.12345;out=standings', {})
    end

    it 'should request /leagues;league_keys=406.l.12345;out=standings,players' do
      YahooFantasy::Resource::League::League.all(filters: { league_keys: %w[406.l.12345] }, out: %w[standings players])
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/leagues;league_keys=406.l.12345;out=standings,players', {})
    end
  end

  context '.get' do
    before(:each) do
      @access_token = spy(OAuth2::AccessToken)
      YahooFantasy::Resource::Base.access_token = @access_token
    end

    it 'should request /league/406.l.12345' do
      YahooFantasy::Resource::League::League.get('406.l.12345')
      expect(@access_token).to have_received(:request).with(:get, 'https://fantasysports.yahooapis.com/fantasy/v2/league/406.l.12345', {})
    end

    it 'should request subresources url' do
      [
        :settings,
        :standings,
        :scoreboard,
        :teams
        # [:players, YahooFantasy::Resource::Player],
        # [:draft_results, YahooFantasy::Resource::League::DraftResults],
        # [:transactions, YahooFantasy::Resource::League::Transation]
      ].each do |sub|
        YahooFantasy::Resource::League::League.get('406.l.12345', out: [sub])
        expect(YahooFantasy::Resource::League::League.subresources.keys.include?(sub[0])).to eq(true), "expected /leagues/406.l.12345;out=#{sub[0]}"
      end
    end
  end
end
