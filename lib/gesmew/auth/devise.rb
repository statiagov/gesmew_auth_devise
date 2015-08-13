require 'gesmew/core'
require 'devise'
require 'devise-encryptable'
require 'cancan'

Devise.secret_key = SecureRandom.hex(50)

module Gesmew
  module Auth
    mattr_accessor :default_secret_key

    def self.config(&block)
      yield(Gesmew::Auth::Config)
    end
  end
end

Gesmew::Auth.default_secret_key = Devise.secret_key

require 'gesmew/auth/engine'
