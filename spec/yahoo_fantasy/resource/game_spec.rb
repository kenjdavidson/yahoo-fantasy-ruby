# frozen_string_literal: true

RSpec.describe YahooFantasy::Resource::Game do
  context 'class definition' do
    it 'has all accessors' do
      %i[game_key game_id name code type url season is_registration_over is_game_over is_offseason].each do |a|
        expect(subject.respond_to?(a)).to eql(true), "expect respond to #{a}"
        expect(subject.respond_to?("#{a}=")).to eql(true), "expect respond to #{a}="
      end
    end
  end

  context 'subresources' do
    it 'responds to subresources call' do
      subject.respond_to? :subresources
    end

    it 'has five (1) subresources' do
      expect(YahooFantasy::Resource::Game.subresources.length).to eq 1
    end

    it 'has leagues subresource' do
      expect(YahooFantasy::Resource::Game.subresources.keys.include?(:leagues)).to eq true
      expect(YahooFantasy::Resource::Game.subresources[:leagues]).to eq YahooFantasy::Resource::League
    end
  end

  context 'filters' do
    it 'has four (4) filters' do
      expect(YahooFantasy::Resource::Game.filters.length).to eq 4
    end

    it 'has is_available filter' do
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:is_available)).to eq true
    end

    it 'has game_types filter' do
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:game_types)).to eq true
    end

    it 'has game_codes filter' do
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:game_codes)).to eq true
    end

    it 'has seasons filter' do
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:seasons)).to eq true
    end
  end

  describe 'XML Parses' do
  end
end
