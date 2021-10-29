RSpec.describe YahooFantasy::XML::GameRepresenter do
  subject(:game) { YahooFantasy::Resource::Game.new }

  before(:example) do 
    access_token = double("access_token", request: {})
    YahooFantasy::Resource::Base.access_token = access_token
  end 

  context "single <game> with no subresources" do 
    let(:xml) { File.read("#{__dir__}/game/game.xml") }

    it "parses game" do         
      YahooFantasy::XML::GameRepresenter.new(game).from_xml(xml)

      expect(game.game_key).to eq(406)
      expect(game.game_id).to eq(406)
      expect(game.name).to eq("Football")
      expect(game.type).to eq("full")
      expect(game.url).to eq("https://football.fantasysports.yahoo.com/f1")
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_registration_over?).to eq(true)
      expect(game.is_game_over).to eq(0)
      expect(game.is_game_over?).to eq(false)
      expect(game.is_offseason).to eq(0)
      expect(game.is_offseason?).to eq(false)
    end 
  end 

  context "single <game> with leagues" do 
    let(:xml) { File.read("#{__dir__}/game/game_leagues.xml") }

    it "parses correctly" do       
      YahooFantasy::XML::GameRepresenter.new(game).from_xml(xml)
    
      expect(game.game_key).to eq(406)
      expect(game.game_id).to eq(406)
      expect(game.name).to eq("Football")
      expect(game.type).to eq("full")
      expect(game.url).to eq("https://football.fantasysports.yahoo.com/f1")
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_registration_over?).to eq(true)
      expect(game.is_game_over).to eq(0)
      expect(game.is_game_over?).to eq(false)
      expect(game.is_offseason).to eq(0)
      expect(game.is_offseason?).to eq(false)
      expect(game.leagues.count).to eq(4)
    end 
  end 

  context "single <game> with game_weeks" do
    let(:xml) { File.read("#{__dir__}/game/game_game_weeks.xml") }

    it "parses correctly" do       
      YahooFantasy::XML::GameRepresenter.new(game).from_xml(xml)
    
      expect(game.game_key).to eq(406)
      expect(game.game_id).to eq(406)
      expect(game.name).to eq("Football")
      expect(game.type).to eq("full")
      expect(game.url).to eq("https://football.fantasysports.yahoo.com/f1")
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_registration_over?).to eq(true)
      expect(game.is_game_over).to eq(0)
      expect(game.is_game_over?).to eq(false)
      expect(game.is_offseason).to eq(0)
      expect(game.is_offseason?).to eq(false)

      expect(game.game_weeks.count).to eq(18)
      expect(game.game_weeks[0].week).to eq(1)
      expect(game.game_weeks[0].display_name).to eq("1")
      expect(game.game_weeks[0].start).to eq("2021-09-09")
      expect(game.game_weeks[0].end).to eq("2021-09-13")
    end   
  end

  # Stat categories is double wrapped in <stats> which I'm unsure will
  # work without a secondarly property level, but will attempt it.
  # <stat> could be shared between different resources and not specific
  # to Game(s)
  context "single <game> with stat_categories" do 
    let(:xml) { File.read("#{__dir__}/game/game_stat_categories.xml") }

    it "parses correctly" do       
      YahooFantasy::XML::GameRepresenter.new(game).from_xml(xml)
    
      expect(game.game_key).to eq(406)
      expect(game.game_id).to eq(406)
      expect(game.name).to eq("Football")
      expect(game.type).to eq("full")
      expect(game.url).to eq("https://football.fantasysports.yahoo.com/f1")
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_registration_over?).to eq(true)
      expect(game.is_game_over).to eq(0)
      expect(game.is_game_over?).to eq(false)
      expect(game.is_offseason).to eq(0)
      expect(game.is_offseason?).to eq(false)

      # expect(game.stat_categories.count).to eq(86)
      # expect(game.stat_[0].week).to eq(1)
      # expect(game.game_weeks[0].display_name).to eq("1")
      # expect(game.game_weeks[0].start).to eq("2021-09-09")
      # expect(game.game_weeks[0].end).to eq("2021-09-13")
    end 
  end

  context "single <game> with position_types" do 
    let(:xml) { File.read("#{__dir__}/game/game_position_types.xml") }

    it "parses correctly" do       
      YahooFantasy::XML::GameRepresenter.new(game).from_xml(xml)
    
      expect(game.game_key).to eq(406)
      expect(game.game_id).to eq(406)
      expect(game.name).to eq("Football")
      expect(game.type).to eq("full")
      expect(game.url).to eq("https://football.fantasysports.yahoo.com/f1")
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_registration_over?).to eq(true)
      expect(game.is_game_over).to eq(0)
      expect(game.is_game_over?).to eq(false)
      expect(game.is_offseason).to eq(0)
      expect(game.is_offseason?).to eq(false)

      expect(game.position_types.count).to eq(4)
      expect(game.position_types[0].type).to eq("O")
      expect(game.position_types[0].display_name).to eq("Offense")
      expect(game.position_types[1].type).to eq("K")
      expect(game.position_types[1].display_name).to eq("Kickers")
      expect(game.position_types[2].type).to eq("DT")
      expect(game.position_types[2].display_name).to eq("Defense/Special Teams")
      expect(game.position_types[3].type).to eq("DP")
      expect(game.position_types[3].display_name).to eq("Defensive Players")
    end 

  end

  context "single <game> with roster_positions" do 
    let(:xml) { File.read("#{__dir__}/game/game_roster_positions.xml") }

    it "parses correctly" do       
      YahooFantasy::XML::GameRepresenter.new(game).from_xml(xml)
    
      expect(game.game_key).to eq(406)
      expect(game.game_id).to eq(406)
      expect(game.name).to eq("Football")
      expect(game.type).to eq("full")
      expect(game.url).to eq("https://football.fantasysports.yahoo.com/f1")
      expect(game.season).to eq(2021)
      expect(game.is_registration_over).to eq(1)
      expect(game.is_registration_over?).to eq(true)
      expect(game.is_game_over).to eq(0)
      expect(game.is_game_over?).to eq(false)
      expect(game.is_offseason).to eq(0)
      expect(game.is_offseason?).to eq(false)

      expect(game.roster_positions.count).to eq(20)
      expect(game.roster_positions[0].position).to eq("QB")
      expect(game.roster_positions[0].abbreviation).to eq("QB")
      expect(game.roster_positions[0].display_name).to eq("Quarterback")
      expect(game.roster_positions[0].position_type).to eq("O")
    end 
  end
end
