module YahooFantasy
  # YahooFantasyError providing access to the parsed YahooFantasy::Resource::FantasyContent
  # and the specific error message.  Error is designed to wrap any OAuth2::Error that occurs
  # during the request.
  #
  # The OAuth2::Error
  #
  class YahooFantasyError < StandardError
    # @return [YahooFantasy::Resource::FantasyContent] the fantasy content response
    attr_reader :fantasy_content

    def initialize(fantasy_content)
      @fantasy_content = fantasy_content

      super(fantasy_content.error)
    end
  end
end