# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module Team
      # Provides access and implementation of Team resource and collection:
      #
      # Resource:
      # https://developer.yahoo.com/fantasysports/guide/#team-resource
      #
      # Collection:
      # https://developer.yahoo.com/fantasysports/guide/#teams-collection
      #
      # Note that at this point the `/stats` subresource isn't currently available as it
      # is not a single entity.  The `/stats` response contains two entities:
      # - team_points
      # - team_projected_points
      #
      # which I wasn't aware of and at this point didn't fit in how I designed the subresource.
      # I'm debating whether to just automatically add `;out=stats` to all requests since it seems
      # like a pretty general think to request.
      #
      # @!attribute mathups
      #   @return [Array<Team::Matchup>]
      # @!attribute roster
      #   @return [Team::Roster]
      # @!attribute standings
      #   @return [Team::Standings]
      # @!attribute draft_results
      #   @return [Draft::DraftResults]
      # @!attribute transactions
      #   @return [Array<Transaction::Transaction>]
      #
      class Team < YahooFantasy::Resource::Base
        filter :team_keys

        subresource :matchups, parser: ->(fc) { fc.team.matchups }
        subresource :roster, parser: ->(fc) { fc.team.roster }
        subresource :standings, parser: ->(fc) { fc.team.team_standings }
        subresource :draft_results, endpoint: '/draftresults',
                                    parser: ->(fc) { fc.team.draft_results }
        subresource :transactions, parser: ->(fc) { fc.team.transactions }

        attr_reader :team_key
        attr_accessor :team_id,
                      :name,
                      :url,
                      :team_logos,
                      :waiver_priority,
                      :number_of_moves,
                      :number_of_trades,
                      :roster_adds,
                      :league_scoring_type,
                      :has_draft_grade,
                      :draft_grade,
                      :draft_recap_url,
                      :managers,
                      :win_probability,
                      :is_owned_by_current_login,
                      :clinched_playoffs

        # team_points and team_projected points are part of the `/stats` subresource.  What I didn't notice ahead of time
        # was that by default the <team_points> is returned, but if you make a finer request for something like
        # `/stats;type=week;week=13` then you'll get two elemnts in here which exactly managed well with the
        # current implementation of team_points!
        #
        # @todo to do this properly we need provide a better implementation that allows for this special type of lookup.
        #   For the time being though, if the main request includes this data, it will just be parsed normally.
        attr_accessor :team_points,
                      :team_projected_points

        # @see YahooFantasy::Resource::Base#get
        # @return [Array<YahooFantasy::Resource::Team::Team>]
        def self.all(options = {})
          super(options, &:teams)
        end

        # @see YahooFantasy::Resource::Base#get
        # @return [YahooFantasy::Resource::Team::Team]
        def self.get(key, options = {})
          super(key, options, &:team)
        end

        # Set the `team_key` and appropriate parent keys
        # @todo provide validation based on `[\d+].l.[\d+].t.[\d+]`
        #
        # @param key [String]
        # @return [String]
        def team_key=(key)
          @league_key = @league_id = @game_key = @game_id = nil
          @team_key = key
        end

        def league_key
          separator = team_key.rindex('.t')
          @league_key ||= team_key[0...separator]
        end

        def league_id
          @league_id ||= league_key.split('.').last.to_i
        end

        def game_key
          @game_key ||= team_key.split('.').first
        end

        def game_id
          @game_id ||= game_key.to_i
        end
      end
    end
  end
end
