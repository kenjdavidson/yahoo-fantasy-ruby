# frozen_string_literal: true

require 'representable/xml'
require 'yahoo_fantasy/xml/league/settings_representer'

module YahooFantasy
  module XML
    # Serialize/Deserialize YahooFantasy:Resource::League
    #
    class LeagueRepresenter < YahooFantasy::XML::BaseRepresenter
      remove_namespaces!

      string_properties :league_key, :name, :url, :logo_url, :draft_status, :scoring_type, :league_type, :renew,
                        :renewed, :iris_group_chat_id, :game_code, :start_date, :end_date
      integer_properties :league_id, :num_teams, :edit_key, :league_update_timestamp, :allow_add_to_dl_extra_pos,
                         :is_pro_league, :is_cash_league, :current_week, :start_week, :end_week, :season

      # Settings
      property :settings, class: YahooFantasy::Resource::League::Settings,
                          decorator: SettingsRepresenter
    end
  end
end
