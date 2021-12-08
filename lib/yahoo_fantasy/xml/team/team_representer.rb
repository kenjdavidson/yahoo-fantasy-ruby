# frozen_string_literal: true

require 'representable/xml'

module YahooFantasy
  module XML
    module Team
      # Serialize/Deserialize YahooFantasy:Resource::Team::Team
      #
      class TeamRepresenter < YahooFantasy::XML::BaseRepresenter
        remove_namespaces!

        points_class = lambda do |fragment:, **|
          case (fragment > 'coverage_type').first.content
          when 'season'
            YahooFantasy::Resource::Team::SeasonPoints
          when 'week'
            YahooFantasy::Resource::Team::WeekPoints
          when 'date'
            YahooFantasy::Resource::Team::DatePoints
          end
        end

        %i[team_key name url league_scoring_type draft_grade draft_recap_url].each do |attr|
          string_properties attr
        end

        %i[team_id waiver_priority number_of_moves number_of_trades has_draft_grade is_owned_by_current_login clinched_playoffs].each do |attr|
          integer_properties attr
        end

        property :roster_adds, class: YahooFantasy::Resource::Team::RosterAdds do
          property :coverage_type
          property :coverage_value, parse_filter: Parsers::IntegerFilter
          property :value, parse_filter: Parsers::IntegerFilter
        end

        # Would be better to provide `class` and `decorator` as custom representors
        # but at this point covering all bases is easy and works
        # @todo clean up to remove duplication
        property :team_points, class: points_class do
          property :coverage_type
          property :season, parse_filter: Parsers::IntegerFilter
          property :week, parse_filter: Parsers::IntegerFilter
          property :date
          property :total, parse_filter: Parsers::FloatFilter
        end

        # Would be better to provide `class` and `decorator` as custom representors
        # but at this point covering all bases is easy and works
        # @todo clean up to remove duplication
        property :team_projected_points, class: points_class do
          property :coverage_type
          property :season, parse_filter: Parsers::IntegerFilter
          property :week, parse_filter: Parsers::IntegerFilter
          property :date
          property :total, parse_filter: Parsers::FloatFilter
        end

        property :roster, class: YahooFantasy::Resource::Team::Roster do
          property :coverage_type
          property :week, parse_filter: Parsers::IntegerFilter
          property :date
          property :is_editable, parse_filter: Parsers::IntegerFilter
          collection :players, wrap: :players, as: :player,
                               class: YahooFantasy::Resource::Player::Player,
                               decorator: YahooFantasy::XML::Player::PlayerRepresenter
        end

        property :standings, as: :team_standings, class: YahooFantasy::Resource::Team::Standings do
          property :rank, parse_filter: Parsers::IntegerFilter
          property :playoff_seed, parse_filter: Parsers::IntegerFilter
          property :wins, wrap: :outcome_totals, parse_filter: Parsers::IntegerFilter
          property :losses, wrap: :outcome_totals, parse_filter: Parsers::IntegerFilter
          property :percentage, wrap: :outcome_totals, parse_filter: Parsers::FloatFilter
          property :ties, wrap: :outcome_totals, parse_filter: Parsers::IntegerFilter
          property :streak_type, wrap: :streak, as: :type
          property :streak_value, wrap: :streak, as: :value, parse_filter: Parsers::IntegerFilter
          property :points_for, parse_filter: Parsers::FloatFilter
          property :points_against, parse_filter: Parsers::FloatFilter
        end

        collection :matchups, wrap: :matchups, as: :matchup,
                              class: YahooFantasy::Resource::Team::Matchup do
          property :week, parse_filter: Parsers::IntegerFilter
          property :week_start
          property :week_end
          property :status
          property :is_playoffs, parse_filter: Parsers::IntegerFilter
          property :is_consolation, parse_filter: Parsers::IntegerFilter
          property :is_matchup_recap_available, parse_filter: Parsers::IntegerFilter
          property :matchup_recap_url
          property :matchup_recap_title
          property :is_tied, parse_filter: Parsers::IntegerFilter
          property :winner_team_key

          collection :matchup_grades, wrap: :matchup_grades, as: :matchup_grade,
                                      class: YahooFantasy::Resource::Team::Matchup::Grade do
                                        property :team_key
                                        property :grade
                                      end
          # collection :teams, wrap: :teams, as: :team,
          #                    class: YahooFantasy::Resource::Team::Team,
          #                    decorator: YahooFantasy::XML::Team::TeamRepresenter
        end

        collection :team_logos, as: :team_logo, wrap: :team_logos,
                                class: YahooFantasy::Resource::Team::Logo do
          property :image_size, as: :size
          property :url
        end

        collection :managers, as: :manager, wrap: :managers,
                              class: YahooFantasy::Resource::Team::Manager do
          property :manager_id, parse_filter: Parsers::IntegerFilter
          property :nickname
          property :guid
          property :is_current_login, parse_filter: Parsers::IntegerFilter
          property :image_url
          property :felo_score, parse_filter: Parsers::IntegerFilter
          property :felo_tier
        end
      end
    end
  end
end
