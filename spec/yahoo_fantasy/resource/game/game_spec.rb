# frozen_string_literal: true

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

  context 'subresources' do
    subject { YahooFantasy::Resource::Game::Game }

    it 'has five (5) subresources' do
      expect(subject.subresources.length).to eq 5

      [
        [:leagues, YahooFantasy::Resource::League],
        [:game_weeks, YahooFantasy::Resource::Game::GameWeek],
        [:roster_positions, YahooFantasy::Resource::Game::RosterPosition],
        [:stat_categories, YahooFantasy::Resource::Game::Statistic],
        [:position_types, YahooFantasy::Resource::Game::PositionType]
      ].each do |sub|
        expect(subject.subresources.keys.include?(sub[0])).to eq(true), "expected #{sub[0]} subresource"
        expect(subject.subresources[sub[0]]).to eq(sub[1]), "expected #{sub[0]} subresource to be #{sub[1].class}"
      end
    end
  end

  context 'filters' do
    subject { YahooFantasy::Resource::Game::Game }

    it 'has four (4) filters' do
      expect(subject.filters.length).to eq 4

      %i[is_available game_types game_codes seasons].each do |filter|
        expect(subject.filters.keys.include?(filter)).to eq(true), "expected #{filter} filter"
      end
    end
  end
end
