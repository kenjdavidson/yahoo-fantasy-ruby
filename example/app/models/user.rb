# User Model
#
# @!attribute id
# @!attribute uid Yahoo! User Id
# @!attribute first_name
# @!attribute last_name
# @!attribute nickname
# @!attribute location
# @!attribute image
# @!attribute credentials Yahoo! OAuth2 tokens
#
class User < ApplicationRecord
  has_one :credential, dependent: :destroy
end
