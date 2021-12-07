# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Team
      # Team matchups available on both the Team and League resources
      #
      class Matchup
        Grade = Struct.new(:team_key, :grade)

        attr_accessor :week, :week_start, :week_end,
                      :status,
                      :is_playoffs,
                      :is_consolation,
                      :is_matchup_recap_available,
                      :matchup_recap_url, :matchup_recap_title,
                      :matchup_grades,
                      :is_tied,
                      :winner_team_key,
                      :teams

        def winning_team
          teams.filter { |team| team.team_key == winner_team_key }
        end

        def winning_team_grade
          matchup_grades.filter { |grade| grade.team_key == winner_team_key }
        end

        def losing_team
          teams.filter { |team| team.team_key != winner_team_key }
        end

        def losing_team_grade
          matchup_grades.filter { |grade| grade.team_key != winner_team_key }
        end
      end
    end
  end
end
