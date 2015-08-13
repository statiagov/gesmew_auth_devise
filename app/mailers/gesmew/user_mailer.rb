module Gesmew
  class UserMailer < BaseMailer
    def reset_password_instructions(user, token, *args)
      @edit_password_reset_url = gesmew.edit_gesmew_user_password_url(:reset_password_token => token, :host => ActionMailer::Base.default_url_options[:host])

      mail to: user.email, from: from_address, subject: "Society & Welfare" + ' ' + I18n.t(:subject, :scope => [:devise, :mailer, :reset_password_instructions])
    end

    def confirmation_instructions(user, token, opts={})
      @confirmation_url = gesmew.gesmew_user_confirmation_url(:confirmation_token => token, :host => ActionMailer::Base.default_url_options[:host])

      mail to: user.email, from: from_address, subject: "Society & Welfare" + ' ' + I18n.t(:subject, :scope => [:devise, :mailer, :confirmation_instructions])
    end
  end
end
