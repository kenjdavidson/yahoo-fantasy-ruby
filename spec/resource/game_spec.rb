RSpec.describe YahooFantasy::Resource::Game do
  context "Game subresources" do 
    it "has five (5) subresources" do 
      expect(YahooFantasy::Resource::Game.subresources.length).to eq 5
    end 

    it "has leagues subresource" do
      expect(YahooFantasy::Resource::Game.subresources.keys.include?(:leagues)).to eq true
      expect(YahooFantasy::Resource::Game.subresources[:leagues]).to eq YahooFantasy::Resource::League
    end

    it "has game_weeks subresource" do
      expect(YahooFantasy::Resource::Game.subresources.keys.include?(:game_weeks)).to eq true
      expect(YahooFantasy::Resource::Game.subresources[:game_weeks]).to eq YahooFantasy::Resource::Game::GameWeek
    end

    it "has stat_categories subresource" do
      expect(YahooFantasy::Resource::Game.subresources.keys.include?(:stat_categories)).to eq true
      expect(YahooFantasy::Resource::Game.subresources[:stat_categories]).to eq YahooFantasy::Resource::Game::StatCategory
    end

    it "has position_types subresource" do
      expect(YahooFantasy::Resource::Game.subresources.keys.include?(:position_types)).to eq true
      expect(YahooFantasy::Resource::Game.subresources[:position_types]).to eq YahooFantasy::Resource::Game::PositionType
    end

    it "has roster_positions subresource" do
      expect(YahooFantasy::Resource::Game.subresources.keys.include?(:roster_positions)).to eq true
      expect(YahooFantasy::Resource::Game.subresources[:roster_positions]).to eq YahooFantasy::Resource::Game::RosterPosition
    end
  end

  context "Game filters" do 
    it "has four (4) filters" do 
      expect(YahooFantasy::Resource::Game.filters.length).to eq 4
    end 

    it "has is_available filter" do 
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:is_available)).to eq true
    end 

    it "has game_types filter" do 
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:game_types)).to eq true
    end 

    it "has game_codes filter" do 
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:game_codes)).to eq true
    end 

    it "has seasons filter" do 
      expect(YahooFantasy::Resource::Game.filters.keys.include?(:seasons)).to eq true
    end 
  end 

  describe "XML Parses" do 

  end 
end
