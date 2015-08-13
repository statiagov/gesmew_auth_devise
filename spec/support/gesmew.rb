require 'gesmew/testing_support/factories'
require 'gesmew/testing_support/url_helpers'
require 'gesmew/testing_support/controller_requests'
require 'gesmew/testing_support/authorization_helpers'
require 'gesmew/testing_support/capybara_ext'

# Monkey patch for pending: https://github.com/gesmew/gesmew/pull/5182
module Gesmew
  module TestingSupport
    module AuthorizationHelpers
      module Controller
        def stub_authorization!(&block)
          ability_class = build_ability(&block)
          before do
            allow(controller).to receive(:current_ability).and_return(ability_class.new(nil))
          end
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Gesmew::TestingSupport::UrlHelpers
  config.include Gesmew::TestingSupport::ControllerRequests, type: :controller
end
