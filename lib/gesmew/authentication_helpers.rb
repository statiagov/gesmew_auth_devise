module Gesmew
  module AuthenticationHelpers
    def self.included(receiver)
      receiver.send :helper_method, :gesmew_current_user
      receiver.send :helper_method, :gesmew_login_path
      receiver.send :helper_method, :gesmew_logout_path
    end

    def gesmew_current_user
      current_gesmew_user
    end

    def gesmew_login_path
      gesmew.login_path
    end

    def gesmew_logout_path
      gesmew.logout_path
    end
  end
end
