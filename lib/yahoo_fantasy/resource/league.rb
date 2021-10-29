module YahooFantasy
  module Resource
    class League < YahooFantasy::Resource::Base 
      # subresource :settings, YahooFantasy::Resource::League::Settings 
      # subresource :standings, YahooFantasy::Resource::League::Standings
      # subresource :scoreboard, YahooFantasy::Resource::League::Scoreboard 
      # subresource :draft_results, YahooFantasy::Resource::League::DraftResults

      filter :league_keys

      attr_accessor :league_key
      attr_accessor :league_id 
      attr_accessor :name 
      attr_accessor :url 
      attr_accessor :draft_status
      attr_accessor :num_teams
      attr_accessor :weekly_deadline
      attr_accessor :league_update_timestamp
      attr_accessor :scoring_type
      attr_accessor :current_week
      
      def self.all
      end
    end 
  end 
end