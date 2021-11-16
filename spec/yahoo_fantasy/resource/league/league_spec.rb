# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::League::League do
  context 'class definition' do
    it 'has all accessors' do
      %i[
        league_key league_id name url logo_url draft_status num_teams edit_key weekly_deadline
        league_update_timestamp scoring_type league_type renew renewed iris_group_chat_id allow_add_to_dl_extra_pos
        is_pro_league is_cash_league current_week start_week start_date end_week end_date game_code season
      ].each do |a|
        expect(subject.respond_to?(a)).to eql(true), "expect respond to #{a}"
        expect(subject.respond_to?("#{a}=")).to eql(true), "expect respond to #{a}="
      end
    end
  end

  context 'subresources' do
    subject { YahooFantasy::Resource::League::League }

    it 'responds to subresources call' do
      subject.respond_to? :subresources
    end

    it 'has four (4) subresources' do
      expect(subject.subresources.length).to eq 4

      [
        [:settings, YahooFantasy::Resource::League::Settings],
        [:standings, YahooFantasy::Resource::Team::Team],
        [:scoreboard, YahooFantasy::Resource::League::Scoreboard],
        [:teams, YahooFantasy::Resource::Team::Team]
        # [:players, YahooFantasy::Resource::Player],
        # [:draft_results, YahooFantasy::Resource::League::DraftResults],
        # [:transactions, YahooFantasy::Resource::League::Transation]
      ].each do |sub|
        expect(subject.subresources.keys.include?(sub[0])).to eq(true), "expected #{sub[0]} subresource"
        expect(subject.subresources[sub[0]]).to eq(sub[1]), "expected #{sub[0]} subresource to be #{sub[1].class}"
      end
    end
  end

  context 'filters' do
    subject { YahooFantasy::Resource::League::League }

    it 'has four (1) filters' do
      expect(subject.filters.length).to eq 1
    end

    it 'has league_keys filter' do
      expect(subject.filters.keys.include?(:league_keys)).to eq true
    end
  end
end
