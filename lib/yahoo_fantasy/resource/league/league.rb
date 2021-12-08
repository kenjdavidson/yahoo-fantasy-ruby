# frozen_string_literal: true

require 'yahoo_fantasy/resource/base'

module YahooFantasy
  module Resource
    module League
      # Provides access and implementation of League resource and collections:
      #
      # Resource:
      # https://developer.yahoo.com/fantasysports/guide/#league-resource
      # https://web.archive.org/web/20130822105844/http://developer.yahoo.com/fantasysports/guide/league-resource.html#league-resource-desc
      #
      # Collections:
      # https://developer.yahoo.com/fantasysports/guide/#leagues-collection
      # https://web.archive.org/web/20130822105532/http://developer.yahoo.com/fantasysports/guide/leagues-collection.html#leagues-collection-desc
      #
      # @!attribute settings
      #   @return [Settings] current league settings.
      # @!attribute scoreboard
      #   @return [Scoreboard] scoreboard for the requested week/date (based on sport).
      # @!attribute standings
      #   @return [Standings] the current league standings.
      # @!attribute teams
      #   @return [Resource::Team::Team] the leagues currently competing in the league
      #
      class League < YahooFantasy::Resource::Base
        filter :league_keys

        subresource :settings, parser: ->(fc) { fc.league.settings }
        subresource :scoreboard, parser: ->(fc) { fc.league.scoreboard }
        subresource :standings, parser: ->(fc) { fc.league.standings }
        subresource :teams, parser: ->(fc) { fc.league.teams }
        subresource :players, parser: ->(fc) { fc.league.players }
        subresource :draft_results, endpoint: '/draftresults',
                                    parser: ->(fc) { fc.league.draft_results }
        # subresource :transactions,

        attr_accessor :league_key, :league_id, :name, :url, :logo_url, :draft_status, :num_teams, :edit_key, :weekly_deadline,
                      :league_update_timestamp, :scoring_type, :league_type, :renew, :renewed, :iris_group_chat_id, :allow_add_to_dl_extra_pos,
                      :is_pro_league, :is_cash_league, :current_week, :start_week, :start_date, :end_week, :end_date, :game_code, :season

        # @todo There's got to be a meta way to do this
        #
        def self.all(options = {})
          super(options, &:leagues)
        end

        # @todo There's got to be a meta way to do this
        #
        def self.get(key, options = {})
          super(key, options, &:league)
        end

        # @return [String] the leagues current game_key
        #
        def game_key
          league_key.split('.').first
        end

        # @return [Number] the leagues current game_id
        #
        def game_id
          game_key.to_i
        end

        # @return [String] the resource path (prefix path for subresources)
        #
        def resource_path
          "/league/#{league_key}"
        end
      end
    end
  end
end
