# frozen_string_literal: true

module YahooFantasy
  module Resource
    module Transaction
      # Once you have the transaction_key for a waiver claim, which you can get by asking the transactions
      # collection for all waivers for a certain team, you can edit the waiver priority or FAAB bid. The
      # input XML should look like:
      #
      # @example
      #   <?xml version='1.0'?>
      #   <fantasy_content>
      #     <transaction>
      #       <transaction_key>248.l.55438.w.c.2_6093</transaction_key>
      #       <type>waiver</type>
      #       <waiver_priority>1</waiver_priority>
      #       <faab_bid>20</faab_bid>
      #     </transaction>
      #   </fantasy_content>
      #
      # @!method edit_priority
      #   @param transaction_key [String]
      #   @param priority [Integer]
      #   @param faab [Integer] optional faab bid
      class WaiverAction
        class << self
          %w[edit_priority].each do |req|
            define_method(req) do |transaction_key, priority, faab|
              WaiverAction.new(transaction_key, priority, faab)
            end
          end
        end

        attr_reader :transaction_key

        # @return [String]
        attr_reader :type

        # @return [Integer] priority greater than 0
        attr_reader :waiver_priority

        # @return [Integer] faab bid
        attr_reader :faab_bid

        # Defines a new action
        #
        # @param transaction_key [String]
        # @param priority [Integer]
        # @param faab [Integer] defaults to nil
        def initialize(transaction_key, priority, faab = nil)
          @transaction_key = transaction_key
          @type = 'waiver'
          @waiver_priority = priority
          @faab_bid = faab unless faab.nil?
        end
      end
    end
  end
end
