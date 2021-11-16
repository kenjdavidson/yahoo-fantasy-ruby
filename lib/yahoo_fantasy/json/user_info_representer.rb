# frozen_string_literal: true

module YahooFantasy
  module JSON
    # UserInfo representer.
    #
    class UserInfoRepresenter < BaseRepresenter
      property :id, as: :sub
      property :name
      property :given_name
      property :family_name
      property :locale
      property :email
      property :birthdate
      property :nickname
      property :picture
    end
  end
end
