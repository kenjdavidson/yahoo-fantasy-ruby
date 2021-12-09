# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Team
      # Team matchups available on both the Team and League resources
      #
      class Matchup
        Grade = Struct.new(:team_key, :grade)

        # @return [Number]
        attr_accessor :week

        # @return [String]
        attr_accessor :week_start

        # @return [String]
        attr_accessor :week_end

        # @return [String]
        attr_accessor :status

        # @return [Number]
        attr_accessor :is_playoffs

        # @return [Number]
        attr_accessor :is_consolation

        # @return [Number]
        attr_accessor :is_matchup_recap_available

        # @return [String]
        attr_accessor :matchup_recap_url

        # @return [String]
        attr_accessor :matchup_recap_title

        # @return [Array<Grade>]
        attr_accessor :matchup_grades

        # @return [Number]
        attr_accessor :is_tied

        # @return [String]
        attr_accessor :winner_team_key

        # @return [Array<YahooFantasy::Resource::Team::Team>]
        attr_accessor :teams

        def initialize
          yield(self) if block_given?
        end

        %i[is_playoffs is_consolation is_matchup_recap_available is_tied].each do |attr|
          define_method "#{attr[3..-1]}?" do
            value = instance_variable_get("@#{attr}")
            !(value.nil? || value.zero?)
          end
        end

        # @return [YahooFantasy::Resource::Team::Team]
        def winning_team
          teams&.filter { |team| team.team_key == winner_team_key }&.first
        end

        # @return [String]
        def winning_team_grade
          matchup_grades&.filter { |grade| grade.team_key == winner_team_key }&.first
        end

        # @return [YahooFantasy::Resource::Team::Team]
        def losing_team
          teams&.filter { |team| team.team_key != winner_team_key }&.first
        end

        # @return [String]
        def losing_team_grade
          matchup_grades&.filter { |grade| grade.team_key != winner_team_key }&.first
        end
      end
    end
  end
end
